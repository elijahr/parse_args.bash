# # argdefs that cover basic functionality
# argdefs=(

#   '-2|--switch-2:switch:off'
#   '-s:string'
#   '--long-1:float'
#   '--long-2:int'
#   '--long-3:bool:42'
#   '--long-3:regex:^matches \:a\: regex$:'
#   '--long-4:int::2:3'
# )

# run parse_args with a bare environment, pass through args, and print the
# resulting arrays
run_parse_args() {
  # clear vars used by assert_* functions
  status=0
  output=""
  lines=()

  script=$(mktemp)
  out=$(mktemp)
  {
    echo 'set -euo pipefail'
    echo 'status=0'
    # shellcheck disable=SC2145
    echo "source ./parse_args.bash ${@@Q} || status=\$?"
    # tell script to print array contents
    echo 'declare -p args'
    echo 'declare -p arg_errors'
    echo 'declare -p argdef_errors'
    # shellcheck disable=SC2016
    echo 'exit $status'
  } >>"$script"
  # run bash with a bare environment
  # shellcheck disable=SC2034
  env -i PATH="${PATH@Q}" HOME="${HOME@Q}" bash --noprofile "$script" >"$out" 2>&1 || status=$?
  output=$(cat "$out")
  # shellcheck disable=SC2034
  readarray -t lines <<<"$output"
  rm "$script" "$out"
}
