load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-f : type(float) : num(unlimited)' --" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__f=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-f : type(float) : num(unlimited)' -- -f 3.14 -f -6.28" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__f=([0]="3.14" [1]="-6.28")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-f : type(float) : num(2,unlimited)' --" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__f=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Missing 2 required arguments for f" )'
}

@test "'-f : type(float) : num(2,unlimited)' -- -f 3.14 -f -6.28" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__f=([0]="3.14" [1]="-6.28")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}
