load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-s:switch::0:0 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=([-s:switch::0:0]="Invalid max-args value 0; must be greater than 0" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:switch::2:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=([-s:switch::2:1]="Invalid min-args value 2; must be less than or equal to max-args value 1" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:switch::1:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Missing required argument s" )'
}

@test "-s:switch::0:1 -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:switch::1:1 -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:switch::1:2 -- -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:switch::1:2 -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="" [1]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:switch::1:2 -- -s -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="" [1]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:switch::1:2 -- -s -s -s=" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="" [1]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:switch::1:2 -- -s -s -s=xyz" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="" [1]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Invalid value '"'xyz'"' for type switch" )'
}

@test "-s:switch::required --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Missing required argument s" )'
}

@test "-s:switch::required:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=([-s:switch::required:2]="Do not specify max-args for required arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:switch::required -- -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:switch::optional -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:switch::optional --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:switch::optional:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=([-s:switch::optional:2]="Do not specify max-args for optional arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:switch::optional -- -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:switch::required -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}
