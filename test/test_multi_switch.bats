load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-s:type(switch):num(0,0) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=(["-s:type(switch):num(0,0)"]="Invalid max-args value 0; must be greater than 0" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:type(switch):num(2,1) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=(["-s:type(switch):num(2,1)"]="Invalid min-args value 2; must be less than or equal to max-args value 1" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:type(switch):num(1,1) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Missing required argument s" )'
}

@test "-s:type(switch):num(0,1) -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:type(switch):num(1,1) -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:type(switch):num(1,2) -- -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:type(switch):num(1,2) -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="" [1]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:type(switch):num(1,2) -- -s -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="" [1]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:type(switch):num(1,2) -- -s -s -s=" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="" [1]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:type(switch):num(1,2) -- -s -s -s=xyz" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__s=([0]="" [1]="")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Invalid value '"'xyz'"' for type switch" )'
}

@test "-s:type(switch):num(required) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Missing required argument s" )'
}

@test "-s:type(switch):num(required,2) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=(["-s:type(switch):num(required,2)"]="Cannot specify min-args or max-args with '"'required'"' or '"'optional'"': required,2" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:type(switch):num(required) -- -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:type(switch):num(optional) -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}

@test "-s:type(switch):num(optional) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:type(switch):num(optional,2) --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=(["-s:type(switch):num(optional,2)"]="Cannot specify min-args or max-args with '"'required'"' or '"'optional'"': optional,2" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:type(switch):num(optional) -- -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-s:type(switch):num(required) -- -s -s" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([s]="" )'
  refute_line --regexp '^declare -a args__s='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([s]="Too many arguments for s" )'
}
