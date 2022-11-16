load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-u|--uint-arg:uint:456'" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([uint-arg]="456" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint:456" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([u]="456" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "--uint-arg:uint:456" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([uint-arg]="456" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}
