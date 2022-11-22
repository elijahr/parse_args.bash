load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-1 | --switch-arg : type(switch)' -- -1" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([switch-arg]="on" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-1 | --switch-arg : type(switch)' -- --switch-arg" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([switch-arg]="on" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-1 : type(switch)' -- -1" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([1]="on" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'--switch-arg : type(switch)' -- --switch-arg" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([switch-arg]="on" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}
