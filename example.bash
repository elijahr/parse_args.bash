#!/usr/bin/env bash

set -ueo pipefail

argdefs=(
  "-h|--help : type(switch)"
  "-v|--version : type(switch)"
  "-n|--name : type(string) : num(required)"
  "-a|--age : type(int) : num(required)"
  "-i|--is-vegetarian : type(bool) : num(optional)"
  "--height : type(float) : num(optional)"
  "--option : num(0,5)"
)

print_help() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -h, --help"
  echo "  -v, --version"
  echo "  -n, --name"
  echo "  -a, --age"
  echo "  -i, --is-vegetarian"
  echo "  --height"
  echo "  --option"
}

parse_status=0
source parse_args.bash "${argdefs[@]}" -- "$@" || parse_status=$?

# required arguments not provided but help or version switches were passed
if [ "${args[help]:-}" = "on" ]; then
  # help switch was passed - call your print_help function
  print_help
  exit 0
fi

if [ "${args[version]:-}" = "on" ]; then
  echo "Version: 1.0.0" >&2
  exit 0
fi

# Some error occurred while parsing arguments
if [ $parse_status -ne 0 ]; then
  if [ $parse_status -eq 1 ]; then
    # Return status 1 indicates the args array could not be parsed
    # i.e. the program was passed invalid arguments
    for key in "${!arg_errors[@]}"; do
      echo "--${key}: ${arg_errors[$key]}" >&2
    done
  elif [ $parse_status -eq 2 ]; then
    # Return status 2 indicates a programmer error; the argdefs are invalid
    for key in "${!argdef_errors[@]}"; do
      echo "${key}: ${argdef_errors[$key]}" >&2
    done
  fi
  exit $parse_status
fi

# No error
echo "Name: ${args[name]}"
echo "Age: ${args[age]}"
echo "Height: ${args[height]:-}"
echo "Is Vegetarian: ${args[is - vegetarian]:-No}"

# "option" accepts up to 5 arguments, so the values are stored in an array
# named `args__option`.
# shellcheck disable=SC2154
for option in "${args__option[@]}"; do
  echo "Option: ${option}"
done
