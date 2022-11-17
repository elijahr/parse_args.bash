load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-1|--switch-arg:switch:xyz -- -1" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=(["-1|--switch-arg:switch:xyz"]="Invalid default value '"'xyz'"' for type switch" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-1|--switch-arg:switch:xyz -- --switch-arg" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=(["-1|--switch-arg:switch:xyz"]="Invalid default value '"'xyz'"' for type switch" )'
  assert_line 'declare -A arg_errors=()'
}

@test "--switch-arg:switch:xyz -- --switch-arg" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=([--switch-arg:switch:xyz]="Invalid default value '"'xyz'"' for type switch" )'
  assert_line 'declare -A arg_errors=()'
}
