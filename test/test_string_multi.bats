load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-s:string::0:0 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=([-s:string::0:0]="Invalid max-args value 0; must be greater than 0" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string::2:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=([-s:string::2:1]="Invalid min-args value 2; must be less than or equal to max-args value 1" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string::1:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Missing required argument s" )'
}

@test "-s:string::0:1 -- -s abc -s tuv" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="abc" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:string::1:1 -- -s abc -s tuv" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="abc" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:string::1:2 -- -s abc" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="abc")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string::1:2 -- -s abc -s tuv" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="abc" [1]="tuv")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string::1:2 -- -s abc -s tuv -s xyz" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="abc" [1]="tuv")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:string::required --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Missing required argument s" )'
}

@test "-s:string::required:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=([-s:string::required:2]="Do not specify max-args for required arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string::required -- -s abc" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="abc" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string::optional -- -s abc -s tuv" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="abc" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:string::optional --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string::optional:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=([-s:string::optional:2]="Do not specify max-args for optional arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string::optional -- -s abc" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="abc" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:string::required -- -s abc -s tuv" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="abc" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}
