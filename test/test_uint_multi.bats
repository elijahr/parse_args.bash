load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-u:uint::0:0 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=([-u:uint::0:0]="Invalid max-args value 0; must be greater than 0" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint::2:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=([-u:uint::2:1]="Invalid min-args value 2; must be less than or equal to max-args value 1" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint::1:1 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Missing required argument u" )'
}

@test "-u:uint::0:1 -- -u 123 -u 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([u]="123" )'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Too many arguments for u" )'
}

@test "-u:uint::1:1 -- -u 123 -u 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([u]="123" )'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Too many arguments for u" )'
}

@test "-u:uint::1:2 -- -u 123" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__u=([0]="123")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint::1:2 -- -u 123 -u 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__u=([0]="123" [1]="456")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint::1:2 -- -u 123 -u 456 -u 789" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__u=([0]="123" [1]="456")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Too many arguments for u" )'
}

@test "-u:uint::1:2 -- -u 123 -u 456 -u xyz" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -a args__u=([0]="123" [1]="456")'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Invalid value '"'xyz'"' for type uint" )'
}

@test "-u:uint::required --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Missing required argument u" )'
}

@test "-u:uint::required:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=([-u:uint::required:2]="Do not specify max-args for required arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint::required -- -u 123" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([u]="123" )'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint::optional -- -u 123 -u 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([u]="123" )'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Too many arguments for u" )'
}

@test "-u:uint::optional --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint::optional:2 --" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=([-u:uint::optional:2]="Do not specify max-args for optional arguments" )'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint::optional -- -u 123" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_success
  assert_line 'declare -A args=([u]="123" )'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=()'
}

@test "-u:uint::required -- -u 123 -u 456" {
  read -ra test_args <<<"$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=([u]="123" )'
  refute_line --regexp '^declare -a args__u='
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Too many arguments for u" )'
}
