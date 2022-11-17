load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-r:regex(abc)::0:0 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=(["-r:regex(abc)::0:0"]="Invalid max-args value 0; must be greater than 0" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-r:regex(abc)::2:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=(["-r:regex(abc)::2:1"]="Invalid min-args value 2; must be less than or equal to max-args value 1" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-r:regex(abc)::1:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Missing required argument r" )'
}

@test "-r:regex(abc)::0:1 -- -r aabcc -r xabcy" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([r]="aabcc" )'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Too many arguments for r" )'
}

@test "-r:regex(abc)::1:1 -- -r aabcc -r xabcy" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([r]="aabcc" )'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Too many arguments for r" )'
}

@test "-r:regex(abc)::1:2 -- -r aabcc" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__r=([0]="aabcc")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-r:regex(abc)::1:2 -- -r aabcc -r xabcy" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__r=([0]="aabcc" [1]="xabcy")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-r:regex(abc)::1:2 -- -r aabcc -r xabcy -r abc123" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__r=([0]="aabcc" [1]="xabcy")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Too many arguments for r" )'
}

@test "-r:regex(abc)::1:2 -- -r aabcc -r xabcy -r xyz" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__r=([0]="aabcc" [1]="xabcy")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Invalid value '"'xyz'"' for type regex(abc)" )'
}

@test "-r:regex(abc)::required --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Missing required argument r" )'
}

@test "-r:regex(abc)::required:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=(["-r:regex(abc)::required:2"]="Do not specify max-args for required arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-r:regex(abc)::required -- -r aabcc" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([r]="aabcc" )'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-r:regex(abc)::optional -- -r aabcc -r xabcy" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([r]="aabcc" )'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Too many arguments for r" )'
}

@test "-r:regex(abc)::optional --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-r:regex(abc)::optional:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=(["-r:regex(abc)::optional:2"]="Do not specify max-args for optional arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-r:regex(abc)::optional -- -r aabcc" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([r]="aabcc" )'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-r:regex(abc)::required -- -r aabcc -r xabcy" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([r]="aabcc" )'
  refute_line --regexp '^declare -a args__r='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Too many arguments for r" )'
}
