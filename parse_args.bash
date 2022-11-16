#!/usr/bin/env bash

_pa_original_bashopts=$(set +o)
set -ueo pipefail

declare -A args=()
declare -A argdef_errors=()
declare -A arg_errors=()

declare -A type_by_name=()
declare -A default_by_name=()
declare -A min_args_by_name=()
declare -A max_args_by_name=()
declare -A count_by_name=()

# order of positional arguments
declare -a pos_order=()
# lookup --help by -h
declare -A long_by_short=()

# Validate a value against a type
_pa_validate_value() {
  local type value
  type="$1"
  value="$2"
  case $type in
  int) [[ $value =~ ^-?[0-9]+$ ]] || return 1 ;;
  uint) [[ $value =~ ^[0-9]+$ ]] || return 1 ;;
  float) [[ $value =~ ^-?[0-9]+(\.[0-9]+)?$ ]] || return 1 ;;
  bool) [[ $value =~ ^(true)|(false)$ ]] || return 1 ;;
  switch) [[ $value =~ ^(on|off)$ ]] || return 1 ;;
  regex\(\)) return 0 ;; # special case for empty regex, matches everything
  regex*)
    if [[ $type =~ (regex\((.*)\)) ]]; then
      [[ $value =~ ${BASH_REMATCH[2]} ]] || return 1
    else
      return 1
    fi
    ;;
  esac
}

# Parse argdefs from the input args
_pa_parse_argdefs() {
  local argdef parts tail_parts short long name type default min_args max_args pos
  while [[ $# -gt 0 ]]; do
    argdef=$1
    shift
    if [ "$argdef" = "--" ]; then
      # done processing argdefs
      break
    fi
    declare -a parts=()

    # check for special case of regex containing colon
    if [[ $argdef =~ ^([^:]+):(regex\(.*\))$ ]]; then
      parts=("${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}")
    elif [[ $argdef =~ ^([^:]+):(regex\(.*\)):(.*) ]]; then
      parts=("${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}")
      IFS=':' read -ra tail_parts <<<"${BASH_REMATCH[3]}"
      parts+=("${tail_parts[@]}")
    else
      IFS=':' read -ra parts <<<"$argdef"
    fi

    if [ ${#parts[@]} -eq 0 ]; then
      # shellcheck disable=SC2034
      argdef_errors[$argdef]="Empty argument definition"
      continue
    fi

    if [[ ${parts[0]} =~ ^-([a-zA-Z0-9])$ ]]; then
      short="${BASH_REMATCH[1]}"
      long=""
      name="${short}"
      pos=""
    elif [[ ${parts[0]} =~ ^--([a-zA-Z0-9_][-a-zA-Z0-9_]{0,})$ ]]; then
      short=""
      long="${BASH_REMATCH[1]}"
      name="${long}"
      pos=""
    elif [[ ${parts[0]} =~ ^-([a-zA-Z0-9])\|--([a-zA-Z0-9_][-a-zA-Z0-9_]{0,})$ ]]; then
      short="${BASH_REMATCH[1]}"
      long="${BASH_REMATCH[2]}"
      long_by_short[$short]=$long
      name="${long}"
      pos=""
    elif [[ ${parts[0]} =~ ^([a-zA-Z0-9_][-a-zA-Z0-9_]{0,})$ ]]; then
      short=""
      long=""
      pos="${BASH_REMATCH[1]}"
      name="${pos}"
    else
      # shellcheck disable=SC2034
      argdef_errors[$argdef]="Invalid argument name: ${parts[0]}"
      continue
    fi

    # verify no other vars with same name
    if [[ -v type_by_name[$name] ]]; then
      # shellcheck disable=SC2034
      argdef_errors[$argdef]="Cannot have multiple argdefs with same name: ${pos}"
      continue
    fi

    type=${parts[1]:-string}

    case $type in
      string|int|uint|float|bool|switch) ;;
      regex\(*\)) ;;
      *)
        # shellcheck disable=SC2034
        argdef_errors[$argdef]="Invalid argument type $type"
        continue
        ;;
    esac

    # switch type is invalid for positional args
    if [ "$type" = "switch" ] && [ -n "$pos" ]; then
      # shellcheck disable=SC2034
      argdef_errors[$argdef]="Invalid type ${type} for positional argument"
      continue
    fi

    min_args=${parts[3]:-}
    max_args=${parts[4]:-}
    if [ "$min_args" = "required" ]; then
      min_args=1
      if [ -n "$max_args" ]; then
        # shellcheck disable=SC2034
        argdef_errors[$argdef]="Do not specify max-args for required arguments"
        continue
      fi
      max_args=1
    elif [ "$min_args" = "" ] || [ "$min_args" = "optional" ]; then
      min_args=0
      if [ -n "$max_args" ]; then
        # shellcheck disable=SC2034
        argdef_errors[$argdef]="Do not specify max-args for optional arguments"
        continue
      fi
      max_args=1
    elif [[ ! $min_args =~ (^[0-9]+$) ]]; then
      # shellcheck disable=SC2034
      argdef_errors[$argdef]="Invalid min-args value ${BASH_REMATCH[1]@Q}"
      continue
    fi

    if [ -z "$max_args" ]; then
      max_args="1"
    elif [ "$max_args" != "unlimited" ]; then
      if [[ $max_args =~ (^[0-9]+$) ]]; then
        if [ ! "$max_args" -gt 0 ]; then
          # shellcheck disable=SC2034
          argdef_errors[$argdef]="Invalid max-args value ${max_args}; must be greater than 0"
          continue
        fi
      else
        # shellcheck disable=SC2034
        argdef_errors[$argdef]="Invalid max-args value ${BASH_REMATCH[1]@Q}; not an integer or 'unlimited'"
        continue
      fi
    fi

    if [ "$max_args" != "unlimited" ] && [ "$min_args" -gt "$max_args" ]; then
      # shellcheck disable=SC2034
      argdef_errors[$argdef]="Invalid min-args value ${min_args}; must be less than or equal to max-args value ${max_args}"
      continue
    fi

    default=${parts[2]:-}
    if [ "$type" = "switch" ] && [ "$default" = "" ]; then
      default=off
    fi

    # if argument is required or has a default value, validate default
    if [ "$min_args" -gt 0 ] || [ -n "$default" ]; then
      if ! _pa_validate_value "$type" "$default"; then
        # shellcheck disable=SC2034
        argdef_errors[$argdef]="Invalid default value ${default@Q} for type ${type}"
        continue
      fi
    fi

    if [ "$min_args" -gt 0 ] && [ "$default" != "" ]; then
      # shellcheck disable=SC2034
      argdef_errors[$argdef]="Cannot specify default value for required argument"
      continue
    fi

    if [ "$type" = "switch" ]; then
      if [ "$min_args" -gt 0 ] || [ "$max_args" -gt 1 ]; then
        # shellcheck disable=SC2034
        argdef_errors[$argdef]="Switch arguments cannot have min-args or max-args greater than 1"
        continue
      fi
    fi

    type_by_name[$name]=$type
    default_by_name[$name]=$default
    min_args_by_name[$name]=$min_args
    max_args_by_name[$name]=$max_args

    if [ -n "$long" ]; then
      long_by_short[$long]=$short
    elif [ -n "$pos" ]; then
      pos_order+=("$pos")
    fi
  done
}

# Parse an array of arguments
_pa_parse_args() {
  local pos_index arg default name value type min_args max_args
  pos_index=0

  # Initialize counts
  for name in "${!type_by_name[@]}"; do
    count_by_name[$name]=0
  done

  # skip argdefs
  while [[ $# -gt 0 ]]; do
    if [ "$1" = "--" ]; then
      shift
      break
    else
      shift
    fi
  done

  while [[ $# -gt 0 ]]; do
    arg=$1
    long=""
    short=""
    pos=""
    name=""
    value=""
    if [[ $arg =~ ^--([a-zA-Z0-9_][-a-zA-Z0-9_]{0,}) ]] || [[ $arg =~ ^-([a-zA-Z0-9_][-a-zA-Z0-9_]{0,}) ]]; then
      if [[ $arg =~ ^--([a-zA-Z0-9_][-a-zA-Z0-9_]{0,}) ]]; then
        # --long arg
        long=${BASH_REMATCH[1]}
        name=$long
        declare -p long
      elif [[ $arg =~ ^-([a-zA-Z0-9_]) ]]; then
        # -short arg
        short=${BASH_REMATCH[1]}

        # prefer --long form if available
        if [[ -v long_by_short[$short] ]]; then
          long=${long_by_short[$short]}
          name=$long
        else
          name=$short
        fi
      else
        # shellcheck disable=SC2034
        arg_errors[$arg]="Invalid argument name"
        shift
        continue
      fi

      if [[ ! -v type_by_name[$name] ]]; then
        # shellcheck disable=SC2034
        arg_errors[$name]="Unknown argument ${arg@Q}"
        shift
        continue
      fi
      type=${type_by_name[$name]}

      # Get value
      if [[ $arg =~ ^-[-a-zA-Z0-9_]+[=:](.*)$ ]] || [[ $arg =~ ^-[a-zA-Z0-9_](.+)$ ]]; then
        # --arg=value, -a=value, --arg:value or -a:value
        if [ "$type" = "switch" ]; then
          # shellcheck disable=SC2034
          arg_errors[$name]="Cannot pass value to switch arguments"
          shift
          continue
        fi

        value=${BASH_REMATCH[1]}
      elif [ "$type" = "switch" ]; then
        default=${default_by_name[$name]}
        if [ "$default" = "off" ]; then
          value=on
        else
          value=off
        fi
      else
        # --arg value or -a value
        shift
        if [ "$#" -eq 0 ]; then
          # shellcheck disable=SC2034
          if [ -n "$long" ]; then
            arg_errors[$name]="Missing value for argument --${long}"
          elif [ -n "$short" ]; then
            arg_errors[$name]="Missing value for argument -${short}"
          else
            arg_errors[$name]="Missing value for argument ${pos}"
          fi
          break
        else
          value=$1
        fi
      fi
    else
      # positional argument
      if [ "$pos_index" -lt "${#pos_order[@]}" ]; then
        pos=${pos_order[$pos_index]}
        name="$pos"
      else
        arg_errors[$name]="Too many positional arguments: ${arg}"
        shift
        continue
      fi
    fi

    if [[ ! -v type_by_name[$name] ]]; then
      # shellcheck disable=SC2034
      arg_errors[$name]="Unknown argumentzz ${arg}"
      shift
      continue
    fi

    type=${type_by_name[$name]}
    default=${default_by_name[$name]}
    min_args=${min_args_by_name[$name]}
    max_args=${max_args_by_name[$name]}

    # if [ "$value" = "" ] && [ "$max_args" -eq 1 ]; then
    #   # if no value given and max-args is 1 then error

    #   # shellcheck disable=SC2034
    #   if [ -n "$long" ]; then
    #     arg_errors[$name]="Missing value for argument --${long}"
    #   elif [ -n "$short" ]; then
    #     arg_errors[$name]="Missing value for argument -${short}"
    #   else
    #     arg_errors[$name]="Missing value for argument ${pos}"
    #   fi
    #   shift
    #   continue
    if ! _pa_validate_value "$type" "$value"; then
      # validate the value against the specified type

      # shellcheck disable=SC2034
      arg_errors[$name]="Invalid value ${value@Q} for type ${type}"
      shift
      continue
    fi

    if [ "$max_args" != "unlimited" ] && [ "${count_by_name[$name]}" -eq "$max_args" ]; then
      # shellcheck disable=SC2034
      arg_errors[$name]="Too many arguments for ${name}"
      shift
      continue
    fi

    count_by_name[$name]=$((count_by_name[$name] + 1))

    # check if maxed out a positional arg
    if [ "$max_args" != "unlimited" ] && [ "${count_by_name[$name]}" -eq "$max_args" ]; then
      if [ -n "${pos}" ]; then
        pos_index=$((pos_index + 1))
      fi
    fi

    if [ "$max_args" = "unlimited" ] || [ "$max_args" -gt 1 ]; then
      # add value to the array
      eval "args__${name}+=('${value@Q}')"
    else
      # shellcheck disable=SC2034
      args[$name]=$value
    fi
    shift
  done

  # Set default values
  for name in "${!default_by_name[@]}"; do
    if [[ ! -v arg_errors[$name] ]] && [[ ! -v args[$name] ]] && [[ -v default_by_name[$name] ]]; then
      default=${default_by_name[$name]}
      args[$name]=$default
    fi
  done
}

_pa_cleanup() {
  eval "${_pa_original_bashopts}"
  unset _pa_original_bashopts default_by_name long_by_short min_args_by_name \
        max_args_by_name count_by_name pos_order type_by_name
  unset -f _pa_validate_value _pa_parse_argdefs _pa_parse_args _pa_cleanup
}

# parse passed in argdefs
_pa_parse_argdefs "$@"

if [ "${#argdef_errors[@]}" -gt 0 ]; then
  _pa_cleanup
  return 2
fi

# declare global arrays for storing multi-value args
for _pa_arg_name in "${!type_by_name[@]}"; do
  _pa_max_args=${max_args_by_name[$_pa_arg_name]}
  if [ "$_pa_max_args" = "unlimited" ] || [ "$_pa_max_args" -gt 1 ]; then
    eval "declare -a args__$_pa_arg_name=()"
  fi
done
unset _pa_arg_name _pa_max_args

# argdefs are valid, proceed to parse args array
_pa_parse_args "$@"

# check that all required args were passed
for _pa_arg_name in "${!type_by_name[@]}"; do
  _pa_min_args=${min_args_by_name[$_pa_arg_name]}
  _pa_count=${count_by_name[$_pa_arg_name]}
  if [ "$_pa_count" -lt "$_pa_min_args" ]; then
    if [ "$_pa_min_args" -eq 1 ]; then
      arg_errors[$_pa_arg_name]="Missing required argument ${_pa_arg_name}"
    else
      arg_errors[$_pa_arg_name]="Missing $((_pa_min_args - _pa_count)) required arguments ${_pa_arg_name}"
    fi
  fi
done
unset _pa_arg_name _pa_min_args _pa_count

if [ "${#arg_errors[@]}" -gt 0 ]; then
  _pa_cleanup
  return 1
fi

_pa_cleanup
return 0
