load ../node_modules/bats-support/load
load ../node_modules/bats-assert/load
load ./lib/utils.bash

@test "-i|--int-arg:int -- -i=3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i|--int-arg:int -- -i:3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i|--int-arg:int -- -i 3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i|--int-arg:int -- -i3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i|--int-arg:int -- --int-arg=3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i|--int-arg:int -- --int-arg:3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i|--int-arg:int -- --int-arg 3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i:int -- -i=3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i:int -- -i:3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i:int -- -i 3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Invalid value '"'3.14'"' for type int" )'
}

@test "-i:int -- -i3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([i]="Invalid value '"'3.14'"' for type int" )'
}

@test "--int-arg:int -- --int-arg=3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}

@test "--int-arg:int -- --int-arg:3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}

@test "--int-arg:int -- --int-arg 3.14" {
  read -a test_args <<< "$BATS_TEST_DESCRIPTION"
  run_parse_args "${test_args[@]}"
  assert_failure
  assert_line 'declare -A args=()'
  assert_line 'declare -A argdef_errors=()'
  assert_line 'declare -A arg_errors=([int-arg]="Invalid value '"'3.14'"' for type int" )'
}


