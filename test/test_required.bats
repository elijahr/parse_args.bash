load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-f:type(float):num(required) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Missing required argument f" )'
}

@test "-f:type(float):num(required,2) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=(["-f:type(float):num(required,2)"]="Cannot specify min-args or max-args with '"'required'"' or '"'optional'"': required,2" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-f:type(float):num(required) -- -f 3.14" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([f]="3.14" )'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-f:type(float):num(required) -- -f 3.14 -f -6.28" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([f]="3.14" )'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Too many arguments for f" )'
}
