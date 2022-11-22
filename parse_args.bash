#!/usr/bin/env bash

_pa_original_bashopts=$(set +o)
set -ueo pipefail

declare -A args=()
declare -A argdef_errors=()
declare -A arg_errors=()

declare -A type_by_name=()
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
    string) return 0 ;;
    switch) [ -z "$value" ] && return 0 ;;
    int) [[ $value =~ ^-?[0-9]+$ ]] && return 0 ;;
    uint) [[ $value =~ ^[0-9]+$ ]] && return 0 ;;
    float) [[ $value =~ ^-?[0-9]+(\.[0-9]+)?$ ]] && return 0 ;;
    bool) [[ $value =~ ^(true)|(false)$ ]] && return 0 ;;
    regex\(\)) return 0 ;; # special case for empty regex, matches everything
    regex*) [[ $type =~ (regex\((.*)\)) ]] &&
      [[ $value =~ ${BASH_REMATCH[2]} ]] &&
      return 0 ;;
  esac
  return 1
}

# Parse argdefs from the input args
_pa_parse_argdefs() {
  local argdef parts short long name type num min_args max_args pos
  while [[ $# -gt 0 ]]; do
    argdef=$1
    shift
    if [ "$argdef" = "--" ]; then
      # done processing argdefs
      break
    fi
    declare -a parts=()
    IFS=':' read -ra parts <<<"$argdef"

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

    type="string"
    min_args=0
    max_args=1
    for part in "${parts[@]:1:${#parts[@]}-1}"; do
      if [[ $part =~ ^type\((.*)\)$ ]]; then
        type="${BASH_REMATCH[1]}"
      elif [[ $part =~ ^num\((.*)\)$ ]]; then
        num="${BASH_REMATCH[1]}"
        if [ "$num" = "optional" ]; then
          max_args=1
        elif [ "$num" = "required" ]; then
          min_args=1
          max_args=1
        elif [ "$num" = "unlimited" ]; then
          min_args=0
          max_args=unlimited
        elif [[ $num =~ ^([0-9]+)(,?)$ ]]; then
          min_args="${BASH_REMATCH[1]}"
        elif [[ $num =~ ^([0-9]+),([ ]*)(([0-9]+)|(unlimited))$ ]]; then
          min_args="${BASH_REMATCH[1]}"
          max_args="${BASH_REMATCH[3]}"
        elif [[ $num =~ (required|optional) ]]; then
          # shellcheck disable=SC2034
          argdef_errors[$argdef]="Cannot specify min-args or max-args with 'required' or 'optional': ${num}"
        else
          # shellcheck disable=SC2034
          argdef_errors[$argdef]="Invalid value: ${num}"
          return 2
        fi
      fi
    done
    case $type in
      string | int | uint | float | bool | switch) ;;
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

    type_by_name[$name]=$type
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
  local pos_index arg name value type min_args max_args
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
        # `--arg=value`, `-a=value`, `--arg:value` or `-a:value`
        value=${BASH_REMATCH[1]}
      elif [ "$type" = "switch" ]; then
        # `--arg` or `-a`
        value=""
      else
        # `--arg value` or `-a value`
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
        if [ -z "$name" ]; then
          name=$pos_index
        fi
        arg_errors[$name]="Too many positional arguments: ${arg}"
        shift
        continue
      fi
    fi

    if [[ ! -v type_by_name[$name] ]]; then
      # shellcheck disable=SC2034
      arg_errors[$name]="Unknown argument ${arg}"
      shift
      continue
    fi

    type=${type_by_name[$name]}
    min_args=${min_args_by_name[$name]}
    max_args=${max_args_by_name[$name]}

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
}

_pa_cleanup() {
  eval "${_pa_original_bashopts}"
  unset _pa_original_bashopts long_by_short min_args_by_name \
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
    eval "declare -a args__${_pa_arg_name}=()"
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
      arg_errors[$_pa_arg_name]="Missing $((_pa_min_args - _pa_count)) required arguments for ${_pa_arg_name}"
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
