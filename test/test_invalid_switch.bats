load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-1 : type(switch)' -- -1=value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([1]="Invalid value '"'value'"' for type switch" )'
}

@test "'-1 : type(switch)' -- -1:value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([1]="Invalid value '"'value'"' for type switch" )'
}

@test "'-1 : type(switch)' -- -1 value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([1]="on" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([0]="Too many positional arguments: value" )'
}

@test "'-1 : type(switch)' -- -1value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([1]="Invalid value '"'value'"' for type switch" )'
}
