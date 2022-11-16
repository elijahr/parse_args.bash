load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "does not leak variables" {
  out=$(mktemp)
  status=0
  # run bash with a bare environment
  env -i PATH="${PATH@Q}" HOME="${HOME@Q}" bash --noprofile \
    test/scripts/test-does-not-leak-variables.bash >"$out" 2>&1 || status=$?
  output=$(cat "$out")
  rm "$out"
  assert_success
  assert_output "success"
}

@test "no argdefs" {
  status=0
  run_parse_args
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'

  run_parse_args --
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'

  run_parse_args -- '-v' '--help'
  assert_failure 1
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([v]="Unknown argument '"'-v'"'" [help]="Unknown argument '"'--help'"'" )'
}

@test "resets bash options" {
  set -x
  run source parse_args.bash
  assert_regex "$-" x
  set +x
  run source parse_args.bash
  assert_regex "$-" '^[^x]+$'
}
