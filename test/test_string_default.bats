load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-s|--string-arg:string:default-value -- -s:actual-value" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s|--string-arg:string:default-value -- --string-arg:actual-value" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string:default-value -- -s:actual-value" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}


