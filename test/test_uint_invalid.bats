load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-u|--uint-arg:uint -- -u=-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u|--uint-arg:uint -- -u:-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u|--uint-arg:uint -- -u -123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u|--uint-arg:uint -- -u-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u|--uint-arg:uint -- --uint-arg=-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u|--uint-arg:uint -- --uint-arg:-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u|--uint-arg:uint -- --uint-arg -123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u:uint -- -u=-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u:uint -- -u:-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u:uint -- -u -123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Invalid value '"'-123'"' for type uint" )'
}

@test "-u:uint -- -u-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([u]="Invalid value '"'-123'"' for type uint" )'
}

@test "--uint-arg:uint -- --uint-arg=-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}

@test "--uint-arg:uint -- --uint-arg:-123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}

@test "--uint-arg:uint -- --uint-arg -123" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([uint-arg]="Invalid value '"'-123'"' for type uint" )'
}


