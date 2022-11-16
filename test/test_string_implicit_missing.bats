load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-s|--string-arg -- -s" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([string-arg]="Missing value for argument --string-arg" )'
}

@test "-s|--string-arg -- --string-arg" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([string-arg]="Missing value for argument --string-arg" )'
}

@test "-s -- -s" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Missing value for argument -s" )'
}

@test "--string-arg -- --string-arg" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([string-arg]="Missing value for argument --string-arg" )'
}

