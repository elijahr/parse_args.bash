load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-r|--regex-arg:regex(a+b+c+) -- -r=1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r|--regex-arg:regex(a+b+c+) -- -r:1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r|--regex-arg:regex(a+b+c+) -- -r 1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r|--regex-arg:regex(a+b+c+) -- -r1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r|--regex-arg:regex(a+b+c+) -- --regex-arg=1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r|--regex-arg:regex(a+b+c+) -- --regex-arg:1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r|--regex-arg:regex(a+b+c+) -- --regex-arg 1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r:regex(a+b+c+) -- -r=1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r:regex(a+b+c+) -- -r:1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r:regex(a+b+c+) -- -r 1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "-r:regex(a+b+c+) -- -r1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([r]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "--regex-arg:regex(a+b+c+) -- --regex-arg=1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "--regex-arg:regex(a+b+c+) -- --regex-arg:1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}

@test "--regex-arg:regex(a+b+c+) -- --regex-arg 1-800-588-2300" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([regex-arg]="Invalid value '"'1-800-588-2300'"' for type regex(a+b+c+)" )'
}


