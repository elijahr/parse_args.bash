load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-i:int::0:0 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=([-i:int::0:0]="Invalid max-args value 0; must be greater than 0" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int::2:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=([-i:int::2:1]="Invalid min-args value 2; must be less than or equal to max-args value 1" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int::1:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Missing required argument i" )'
}

@test "-i:int::0:1 -- -i -123 -i 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([i]="-123" )'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Too many arguments for i" )'
}

@test "-i:int::1:1 -- -i -123 -i 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([i]="-123" )'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Too many arguments for i" )'
}

@test "-i:int::1:2 -- -i -123" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__i=([0]="-123")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int::1:2 -- -i -123 -i 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__i=([0]="-123" [1]="456")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int::1:2 -- -i -123 -i 456 -i 789" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__i=([0]="-123" [1]="456")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Too many arguments for i" )'
}

@test "-i:int::1:2 -- -i -123 -i 456 -i xyz" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__i=([0]="-123" [1]="456")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Invalid value '"'xyz'"' for type int" )'
}

@test "-i:int::required --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Missing required argument i" )'
}

@test "-i:int::required:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=([-i:int::required:2]="Do not specify max-args for required arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int::required -- -i -123" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([i]="-123" )'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int::optional -- -i -123 -i 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([i]="-123" )'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Too many arguments for i" )'
}

@test "-i:int::optional --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int::optional:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=([-i:int::optional:2]="Do not specify max-args for optional arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int::optional -- -i -123" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([i]="-123" )'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-i:int::required -- -i -123 -i 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([i]="-123" )'
  refute_line --regexp '^declare -a args__i='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Too many arguments for i" )'
}
