load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-f:type(float):num(0,0) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=(["-f:type(float):num(0,0)"]="Invalid max-args value 0; must be greater than 0" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-f:type(float):num(2,1) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=(["-f:type(float):num(2,1)"]="Invalid min-args value 2; must be less than or equal to max-args value 1" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-f:type(float):num(1,1) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Missing required argument f" )'
}

@test "-f:type(float):num(0,1) -- -f 3.14 -f -6.28" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([f]="3.14" )'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Too many arguments for f" )'
}

@test "-f:type(float):num(1,1) -- -f 3.14 -f -6.28" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([f]="3.14" )'
  refute_line --regexp '^declare -a args__f='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Too many arguments for f" )'
}

@test "-f:type(float):num(1,2) -- -f 3.14" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__f=([0]="3.14")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-f:type(float):num(1,2) -- -f 3.14 -f -6.28" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__f=([0]="3.14" [1]="-6.28")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-f:type(float):num(1,2) -- -f 3.14 -f -6.28 -f 789" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__f=([0]="3.14" [1]="-6.28")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Too many arguments for f" )'
}

@test "-f:type(float):num(1,2) -- -f 3.14 -f -6.28 -f xyz" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__f=([0]="3.14" [1]="-6.28")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([f]="Invalid value '"'xyz'"' for type float" )'
}
