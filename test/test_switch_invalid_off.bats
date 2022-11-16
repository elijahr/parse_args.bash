load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-1:switch:off -- -1=value" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([1]="Cannot pass value to switch arguments" )'
}

@test "-1:switch:off -- -1:value" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([1]="Cannot pass value to switch arguments" )'
}

@test "-1:switch:off -- -1value" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([1]="Cannot pass value to switch arguments" )'
}

