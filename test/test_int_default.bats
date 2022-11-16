load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-i|--int-arg:int:-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([int-arg]="-123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int:-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([i]="-123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "--int-arg:int:-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([int-arg]="-123" )'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-i|--int-arg:int:zzz" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=(["-i|--int-arg:int:zzz"]="Invalid default value '"'zzz'"' for type int" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int:zzz" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=([-i:int:zzz]="Invalid default value '"'zzz'"' for type int" )'
  assert_line 'declare -A arg_errors=()'
}

@test "--int-arg:int:zzz" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=([--int-arg:int:zzz]="Invalid default value '"'zzz'"' for type int" )'
  assert_line 'declare -A arg_errors=()'
}
