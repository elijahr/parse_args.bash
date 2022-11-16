# parse_args.bash

a sourceable bash script for inline parsing of arguments

```
Usage: source parse_args.bash [ARGDEF] [ARGDEF] ...

ARGDEF:

  A string of one of these forms:

    -<short>|--<long>[:<type>][:<default>][:<min-args|required|optional>][:<max-args|unlimited>]

    -<short>[:<type>][:<default>][:<min-args|required|optional>][:<max-args|unlimited>]

    --<long>[:<type>][:<default>][:<min-args|required|optional>][:<max-args|unlimited>]

    <pos>[:<type>][:<default>][:<min-args|required|optional>][:<max-args|unlimited>]

  where:

    <short>
      is a single character e.g. 'h' for the '-h' option.

    <long>
      is a string of characters e.g. 'version' for the '--version' option.

    <pos>
      is a string of characters, and must be unique e.g. 'name' for the
      'name' positional argument.

    [<type>]
      is the optional type, one of 'string', 'int', 'int(min, max)',
      'uint', 'uint(min, max), 'float', 'float(min, max)', 'bool', 'switch',
      or 'regex(<regex>)' where <regex> is a valid bash regex string that can
      be used with the =~ operator.
      (default: 'string')

    [<default>]
      is a string of characters containing the default value for the
      argument.
      (default: '')

    [<min-args>]
      is an integer or one of the strings 'optional' or 'required'.
      'optional' means that the argument is optional and can occur zero or one
      times. 'required' means that the argument is required and must occur once
      and only once. An integer means that the argument must occur at least
      that many times.
      (default: '0')

    [<max-args>]
      is an integer or the string 'unlimited'. 'unlimited' means that the
      argument can occur any number of times more than the min-args value. An
      integer means that the argument must occur at most that many times.
      (default: '1')
```

# Example:

```bash
argdefs=(
  "-h|--help:switch"
  "-v|--version:switch"
  "-n|--name:string:min_args"
  "-a|--age:int:min_args"
  "-i|--is-vegetarian:bool"
  "--height:float:3.14"
  "-o|--option:string:0:5"
)

if source parse_args.bash "${argdefs[@]}" -- "$@"; then
  if [ "${parsed_args[help]}" = "on" ]; then
    # help switch was passed
    # parse_args.bash provides a helper function to print usage
    print_usage
    exit 0
  fi

  if [ "${parsed_args[version]}" = "on" ]; then
    echo "Version: 1.0.0" >&2
    exit 0
  fi

  echo "Name: ${parsed_args[name]}"
  echo "Age: ${parsed_args[age]}"
  echo "Height: ${parsed_args[height]}"
  # Options with + are stored in an array named `parsed_args__<optionname>`
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

- Be the de facto argument parser in the Bash ecosystem.

parse_args behavior can be set via variables prior to sourcing this script:

pa_output_array_name=<string>
The name of the associative array to write parsed arguments to. Defaults to
'parsed_args'.

pa_argdef_error_array_name=<string>
The name of the associative array to write errors parsing the argdefs to.
Defaults to 'argdef_errors'.

pa_arg_error_array_name=<string>
The name of the associative array to write errors parsing the args to.
Defaults to 'parsing_errors'.

# TODO

# - verify no namespace collisions with existing functions, variables and env vars before setting any variables

# - a bats test should verify all variables are unset - using something like this https://stackoverflow.com/questions/1305237/how-to-list-variables-declared-in-script-in-bash

# - implement print_usage

# - works with zsh?

# - create separate repo with tests and such
