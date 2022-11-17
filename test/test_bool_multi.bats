load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-b:bool::0:0 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=([-b:bool::0:0]="Invalid max-args value 0; must be greater than 0" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool::2:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=([-b:bool::2:1]="Invalid min-args value 2; must be less than or equal to max-args value 1" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool::1:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Missing required argument b" )'
}

@test "-b:bool::0:1 -- -b true -b false" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([b]="true" )'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Too many arguments for b" )'
}

@test "-b:bool::1:1 -- -b true -b false" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([b]="true" )'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Too many arguments for b" )'
}

@test "-b:bool::1:2 -- -b true" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__b=([0]="true")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool::1:2 -- -b true -b false" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__b=([0]="true" [1]="false")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool::1:2 -- -b true -b false -b true" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__b=([0]="true" [1]="false")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Too many arguments for b" )'
}

@test "-b:bool::1:2 -- -b true -b false -b xyz" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__b=([0]="true" [1]="false")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Invalid value '"'xyz'"' for type bool" )'
}

@test "-b:bool::required --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Missing required argument b" )'
}

@test "-b:bool::required:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=([-b:bool::required:2]="Do not specify max-args for required arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool::required -- -b true" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="true" )'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool::optional -- -b true -b false" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([b]="true" )'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Too many arguments for b" )'
}

@test "-b:bool::optional --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool::optional:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=([-b:bool::optional:2]="Do not specify max-args for optional arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool::optional -- -b true" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([b]="true" )'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-b:bool::required -- -b true -b false" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([b]="true" )'
  refute_line --regexp '^declare -a args__b='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([b]="Too many arguments for b" )'
}
