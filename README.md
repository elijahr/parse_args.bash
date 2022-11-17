# parse_args.bash

a sourceable bash script for inline parsing of arguments

```
Usage: source parse_args.bash [ARGDEF+] -- [ARG+]

ARGDEF:

  A string of one of these forms:

    -<short>|--<name>:type(<type>):default(<default>):default-array(<default>):num(<num>):mode(<mode>)

    <name>:type(<type>):default(<default>):default-array(<default-array>):num(<num>):mode(<mode>)

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

    <default>
      the default value for the argument if not provided.
      invalid if if max-args > 1.
      (default: '')

    <default-array>
      the name of an array to copy values from into "args__<name>".
      invalid if max-args <= 0.
      (default: '')

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

    <mode>
      one of:
        'store' 'append'
      'store': if <max-args> is <=1, values are placed in the 'args' array.
      'store': if <max-args> is > 1, values are placed in an "args__<name>" array.
      'append': if <max-args> is <=1, 'append' is an invalid <mode>.
      'append': if <max-args> is > 1, values from <default-array> are placed
                in "args__<name>" and additional parsed values are appended to
                the array.
      (default: 'store')
```

# Example:

```bash
default_options=("send-notification")
argdefs=(
  "-h|--help:switch"
  "-v|--version:switch"
  "-n|--name:string:min_args"
  "-a|--age:int:min_args"
  "-i|--is-vegetarian:bool"
  "--height:float:3.14"
  "-o|--option:string:default_options:0:5:append"
)

if source parse_args.bash "${argdefs[@]}" -- "$@"; then
  if [ "${parsed_args[help]}" = "" ]; then
    # help switch was passed
    # parse_args.bash provides a helper function to print usage
    print_usage
    exit 0
  fi

  if [ "${parsed_args[version]}" = "" ]; then
    echo "Version: 1.0.0" >&2
    exit 0
  fi

  echo "Name: ${parsed_args[name]}"
  echo "Age: ${parsed_args[age]}"
  echo "Height: ${parsed_args[height]}"
  # "option" accepts up to 5 arguments, so the values are stored in an array
  # named `parsed_args__option`. Values from `default_options` are copied
  # into `parsed_args__option` because the 'append' mode was passed.
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

# Philosophy

## Flexibility

- Common argument patterns: `--arg value, --arg=value, --arg:value`
- Required and optional arguments, or specific min/max arg counts
- Type checking and pattern matching: `float, int, bool, uint`
- Single-file; download the script to your repo and use as needed
- No viral licensing: MIT Licensed
- Full Bash and ZSH support

## Completeness

- Clear and concise argument definition format
- Argument parsing for both functions and commands

## Predictability

- Unit tests cover common and edge cases
- Precise error codes and error messages
- Fulfill contract outlined in documentation
- No namespace pollution

## Excellence

- Be excellent enough to be considered the de facto argument parser in the Bash ecosystem.

### TODO

- implement print_usage / print_help
- test against zsh
- Implement min/max for int, uint, float
- Implement "keyvalue" type which makes args\_\_<argname> an associative array
- Improve docs
