load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-b | --bool-arg : type(bool)' -- -b=true" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b | --bool-arg : type(bool)' -- -b:true" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b | --bool-arg : type(bool)' -- -b true" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b | --bool-arg : type(bool)' -- -btrue" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b | --bool-arg : type(bool)' -- --bool-arg=true" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b | --bool-arg : type(bool)' -- --bool-arg:true" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b | --bool-arg : type(bool)' -- --bool-arg true" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b : type(bool)' -- -b=true" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b : type(bool)' -- -b:true" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b : type(bool)' -- -b true" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b : type(bool)' -- -btrue" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="true" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}
