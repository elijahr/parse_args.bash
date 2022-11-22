#!/usr/bin/env bash

set -ueo pipefail

_patest_declare_strip() {
  # Strip out all expected items from `declare -p` output.
  grep -v '^[A-Z_]\{1,\}=' |
    grep -v '^declare -.\{1,2\} [A-Z_]\{1,\}' |
    grep -v '^ \{1,\}' |
    grep -v '^[{}]' |
    grep -v '_patest' |
    grep -v '^declare -A args=()$' |
    grep -v '^declare -A arg_errors=()$' |
    grep -v '^declare -A argdef_errors=()$' |
    grep -v '^args=()$' |
    grep -v '^arg_errors=()$' |
    grep -v '^argdef_errors=()$'
}

_patest_set_strip() {
  # Strip out all expected items from `set` output.
  grep -v '^[A-Z0-9_]\{1,\}=' |
    grep -v '^_patest' |
    grep -v '^args=()$' |
    grep -v '^arg_errors=()$' |
    grep -v '^argdef_errors=()$'
}

_patest_original_set=$(set | _patest_set_strip)
_patest_original_declare=$(declare -p | _patest_declare_strip)
source parse_args.bash "$@"
_patest_new_set=$(set | _patest_set_strip)
_patest_new_declare=$(declare -p | _patest_declare_strip)
if [ "$_patest_new_declare" != "$_patest_original_declare" ]; then
  echo "declare -p changed"
  diff -u <(echo "$_patest_original_declare") <(echo "$_patest_new_declare")
  exit 2
fi
if [ "$_patest_new_set" != "$_patest_original_set" ]; then
  echo "set changed"
  diff -u <(echo "$_patest_original_set") <(echo "$_patest_new_set")
  exit 3
fi
echo success
