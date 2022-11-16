load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "'-b|--bool-arg:bool' -- -b=false" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b|--bool-arg:bool' -- -b:false" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b|--bool-arg:bool' -- -b false" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b|--bool-arg:bool' -- -bfalse" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b|--bool-arg:bool' -- --bool-arg=false" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b|--bool-arg:bool' -- --bool-arg:false" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "'-b|--bool-arg:bool' -- --bool-arg false" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([bool-arg]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool -- -b=false" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool -- -b:false" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool -- -b false" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool -- -bfalse" {
  eval test_args=($BATS_TEST_DESCRIPTION)
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="false" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}
