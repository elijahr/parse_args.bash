load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-s | --string-arg : type(string)' -- -s=actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s | --string-arg : type(string)' -- -s:actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s | --string-arg : type(string)' -- -s actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s | --string-arg : type(string)' -- -sactual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s | --string-arg : type(string)' -- --string-arg=actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s | --string-arg : type(string)' -- --string-arg:actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s | --string-arg : type(string)' -- --string-arg actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s : type(string)' -- -s=actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s : type(string)' -- -s:actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s : type(string)' -- -s actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-s : type(string)' -- -sactual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'--string-arg : type(string)' -- --string-arg=actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'--string-arg : type(string)' -- --string-arg:actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'--string-arg : type(string)' -- --string-arg actual-value" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([string-arg]="actual-value" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}
