load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-b|--bool-arg:bool' -- -b" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Missing value for argument --bool-arg" )'
}

@test "'-b|--bool-arg:bool' -- --bool-arg" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Missing value for argument --bool-arg" )'
}

@test "-b:bool -- -b" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Missing value for argument -b" )'
}

@test "--bool-arg:bool -- --bool-arg" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Missing value for argument --bool-arg" )'
}