load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-f : type(float) : num(optional)' -- -f 3.14 -f -6.28" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([f]="3.14" )'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Too many arguments for f" )'
}

@test "'-f : type(float) : num(optional)' --" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-f : type(float) : num(optional,2)' --" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=(["-f : type(float) : num(optional,2)"]="Cannot specify min-args or max-args with '"'required'"' or '"'optional'"': optional,2" )'
  assert_line 'declare -A arg_errors=()'
}

@test "'-f : type(float) : num(optional)' -- -f 3.14" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([f]="3.14" )'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}
