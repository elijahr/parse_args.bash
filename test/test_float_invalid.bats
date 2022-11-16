load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-f|--float-arg:float' -- -f=bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f|--float-arg:float' -- -f:bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f|--float-arg:float' -- -f bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f|--float-arg:float' -- -fbogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f|--float-arg:float' -- --float-arg=bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f|--float-arg:float' -- --float-arg:bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "'-f|--float-arg:float' -- --float-arg bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "-f:float -- -f=bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Invalid value '"'bogus'"' for type float" )'
}

@test "-f:float -- -f:bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Invalid value '"'bogus'"' for type float" )'
}

@test "-f:float -- -f bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Invalid value '"'bogus'"' for type float" )'
}

@test "-f:float -- -fbogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Invalid value '"'bogus'"' for type float" )'
}

@test "--float-arg:float -- --float-arg=bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "--float-arg:float -- --float-arg:bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}

@test "--float-arg:float -- --float-arg bogus" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([float-arg]="Invalid value '"'bogus'"' for type float" )'
}


