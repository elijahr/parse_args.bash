load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-u | --uint-arg : type(uint)' -- -u=123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([uint-arg]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u | --uint-arg : type(uint)' -- -u:123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([uint-arg]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u | --uint-arg : type(uint)' -- -u 123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([uint-arg]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u | --uint-arg : type(uint)' -- -u123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([uint-arg]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u | --uint-arg : type(uint)' -- --uint-arg=123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([uint-arg]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u | --uint-arg : type(uint)' -- --uint-arg:123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([uint-arg]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u | --uint-arg : type(uint)' -- --uint-arg 123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([uint-arg]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u : type(uint)' -- -u=123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([u]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u : type(uint)' -- -u:123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([u]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u : type(uint)' -- -u 123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([u]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-u : type(uint)' -- -u123" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([u]="123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}
