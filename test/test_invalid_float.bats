load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-f | --float-arg : type(float)' -- -f=bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f | --float-arg : type(float)' -- -f:bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f | --float-arg : type(float)' -- -f bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f | --float-arg : type(float)' -- -fbogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f | --float-arg : type(float)' -- --float-arg=bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f | --float-arg : type(float)' -- --float-arg:bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f | --float-arg : type(float)' -- --float-arg bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f : type(float)' -- -f=bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f : type(float)' -- -f:bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f : type(float)' -- -f bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f : type(float)' -- -fbogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Invalid value '"'bogus'"' for type float" )'
}

@test "'--float-arg : type(float)' -- --float-arg=bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'--float-arg : type(float)' -- --float-arg:bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'--float-arg : type(float)' -- --float-arg bogus" {
  eval "declare -a test_args=($BATS_TEST_DESCRIPTION)"
  # shellcheck disable=SC2154
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}
