load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-f:float::required --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Missing required argument f" )'
}

@test "-f:float::required:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=([-f:float::required:2]="Do not specify max-args for required arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-f:float::required -- -f 3.14" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([f]="3.14" )'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-f:float::required -- -f 3.14 -f -6.28" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([f]="3.14" )'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Too many arguments for f" )'
}
