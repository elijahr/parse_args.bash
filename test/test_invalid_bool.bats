load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-b | --bool-arg : type(bool)' -- -b=bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b | --bool-arg : type(bool)' -- -b:bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b | --bool-arg : type(bool)' -- -b bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b | --bool-arg : type(bool)' -- -bbogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b | --bool-arg : type(bool)' -- --bool-arg=bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b | --bool-arg : type(bool)' -- --bool-arg:bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b | --bool-arg : type(bool)' -- --bool-arg bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b : type(bool)' -- -b=bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b : type(bool)' -- -b:bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b : type(bool)' -- -b bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'-b : type(bool)' -- -bbogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'--bool-arg : type(bool)' -- --bool-arg=bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'--bool-arg : type(bool)' -- --bool-arg:bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}

@test "'--bool-arg : type(bool)' -- --bool-arg bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([bool-arg]="Invalid value '"'bogus'"' for type bool" )'
}
