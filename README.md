# parse_args.bash

a sourceable bash script for inline parsing of arguments

```
Usage: source parse_args.bash [ARGDEF] [ARGDEF] ...

ARGDEF:

  A string of one of these forms:

    -<short>|--<long>[:<type>][:<default>][:<min-args|required|optional>][:<max-args|unlimited>][:<mode>]

    -<short>[:<type>][:<default>][:<min-args|required|optional>][:<max-args|unlimited>][:<mode>]

    --<long>[:<type>][:<default>][:<min-args|required|optional>][:<max-args|unlimited>][:<mode>]

    <pos>[:<type>][:<default>][:<min-args|required|optional>][:<max-args|unlimited>][:<mode>]

  where:

    <short>
      is a single character e.g. 'h' for the '-h' option.

    <long>
      is a string of characters e.g. 'version' for the '--version' option.

    <pos>
      is a string of characters, and must be unique e.g. 'name' for the
      'name' positional argument.

    [<type>]
      is optional, one of the strings 'string', 'int', 'uint', 'float', 'bool',
      'switch', or 'regex(<regex>)' where <regex> is a valid bash regex string
      that can be used with the =~ operator.
      (default: 'string')

    [<default>]
      is optional, a string of characters containing the default value for the
      argument. If max-args > 1 this can be a string containing the name of a
      bash array to pull default values from if no arguments are passed
      matching this argdef.
      (default: '')

    [<min-args>]
      is optional, an integer or one of the strings 'optional' or 'required'.
      An integer means that the argument must occur at least that many times.
      'optional' means that the argument is optional and can occur zero or one
      times. 'required' means that the argument is required and must occur once
      and only once.
      (default: '0')

    [<max-args>]
      is optional, an integer or the string 'unlimited'. An integer means that
      the argument must occur at most that many times. 'unlimited' means that
      the argument can occur any number of times more than the min-args value.
      (default: '1')

    [<mode>]
      is optional, the string 'store'. When max-args is > 1 and default is set,
      this can also be the string 'append'. If 'append', all values from
      the default array will be copied to the output array prior to processing
      input arguments..
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
- Type checking and pattern matching: `float, int, bool, regex`
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
