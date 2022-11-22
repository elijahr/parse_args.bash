[![test](https://github.com/elijahr/parse_args.bash/actions/workflows/test.yml/badge.svg)](https://github.com/elijahr/parse_args.bash/actions/workflows/test.yml) [![lint](https://github.com/elijahr/parse_args.bash/actions/workflows/lint.yml/badge.svg)](https://github.com/elijahr/parse_args.bash/actions/workflows/lint.yml)

# parse_args.bash

a sourceable bash script for inline parsing of arguments

```
Usage: source parse_args.bash [ARGDEF+] -- [ARG+]

ARGDEF:

  A string of one of these forms:

    -<short>|--<name>:type(<type>):num(<num>)

    <name>:type(<type>):num(<num>)

  where:

    <short>
      is a single character e.g. 'h' for the '-h' option.

    <name>
      is a string of characters e.g. 'version' for the '--version' keyword
      argument or 'id' for the 'id' positional argument.

    <type>
      one of:
        'string' 'int' 'uint' 'float' 'bool' 'switch'
      the type to validate the argument against
      (default: 'string')

    <num>
      one of:
        'optional' 'required' 'unlimited' '<min-args>,[<max-args>]'
      'optional': shorthand for '0,1'
      'required': shorthand for '1,1'
      'unlimited': shorthand for '0,'
      (default: 'optional')

    <min-args>
      an integer, the minimum acceptable number of arguments.

    <max-args>
      an integer, the maximum acceptable number of arguments.
      if max-args is > 1, an array "args__<name>" will contain the parsed
      argument values.

```

# Example:

```bash
argdefs=(
  "-h|--help : type(switch)"
  "-v|--version : type(switch)"
  "-n|--name : type(string) : num(required)"
  "-a|--age : type(int) : num(required)"
  "-i|--is-vegetarian : type(bool) : num(optional)"
  "--height : type(float) : num(optional)"
  "--option : num(0,5)"
)

if source parse_args.bash "${argdefs[@]}" -- "$@"; then
  if [ "${parsed_args[help]}" = "on" ]; then
    # help switch was passed - call your print_help function
    print_help
    exit 0
  fi

  if [ "${parsed_args[version]}" = "on" ]; then
    echo "Version: 1.0.0" >&2
    exit 0
  fi

  echo "Name: ${parsed_args[name]}"
  echo "Age: ${parsed_args[age]}"
  echo "Height: ${parsed_args[height]}"

  # "option" accepts up to 5 arguments, so the values are stored in an array
  # named `parsed_args__option`.
  for option in "${parsed_args__option[@]}"; do
    echo "Option: ${option}"
  done
  exit 0
else
  # error parsing argdefs or arguments
  parse_status=$?
  if [ $parse_status -eq 1 ]; then
    # Return status 1 indicates the args array could not be parsed
    # i.e. the program was passed invalid arguments
    for key in "${!arg_errors[@]}"; do
      echo "  ${key}: ${arg_errors[$key]}" >&2
    done
  elif [ $parse_status -eq 2 ]; then
    # Return status 2 indicates a programmer error; the argdefs are invalid
    for key in "${!argdef_errors[@]}"; do
      echo "  ${key}: ${argdef_errors[$key]}" >&2
    done
  fi
  exit $parse_status
fi
```

### TODO

- implement print_usage / print_help
- test against zsh
- Implement "keyvalue" type which makes args\_\_<argname> an associative array
- Improve docs
