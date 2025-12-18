#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

status=0

fail() {
  echo "FAIL: $1"
  status=1
}

warn() {
  echo "WARN: $1"
}

check_path() {
  local path="$1"
  local type="$2"
  if [ "$type" = "file" ] && [ ! -f "$path" ]; then
    fail "Missing file: $path"
  elif [ "$type" = "dir" ] && [ ! -d "$path" ]; then
    fail "Missing directory: $path"
  fi
}

check_ascii() {
  local file="$1"
  [ -f "$file" ] || return
  local matches
  matches=$(LC_ALL=C grep -n '[^[:print:]\t]' "$file" || true)
  if [ -n "$matches" ]; then
    echo "FAIL: Non-ASCII characters in $file"
    echo "$matches"
    status=1
  fi
}

map_alias() {
  local role="$1"
  case "$role" in
    full-stack-developer.md) echo "fullstack-developer.md" ;;
    documentation-expert.md) echo "documentation-engineer.md" ;;
    backend-architect.md) echo "backend-developer.md" ;;
    *) echo "$role" ;;
  esac
}

find_match() {
  local role="$1"
  shift
  local candidates=("$role" "$@")
  local c match
  for c in "${candidates[@]}"; do
    match=$(find agents_full -type f -name "$c" -print -quit)
    if [ -n "$match" ]; then
      echo "$match"
      return 0
    fi
  done
  return 1
}

check_path "AGENTS.md" file
check_path "agents_full" dir
check_path "agents_full/INDEX.md" file
check_path "agents" dir
check_path "agents/ROLESET.md" file

ROLESET="agents/ROLESET.md"
listed_roles=()
while IFS= read -r line; do
  case "$line" in
    "- "*) 
      role="${line#- }"
      role="${role%% *}"
      case "$role" in
        *.md) listed_roles+=("$role") ;;
      esac
      ;;
  esac
done < "$ROLESET"
role_count=${#listed_roles[@]}

if (( role_count == 0 )); then
  echo "NOTE: No roles listed in agents/ROLESET.md"
fi

if (( role_count > 8 )); then
  echo "WARN: More than 8 roles listed ($role_count). Confirm this is intended."
fi

for role in "${listed_roles[@]}"; do
  if [ ! -f "agents/$role" ]; then
    fail "Listed role missing from agents/: agents/$role"
  fi
  alias=$(map_alias "$role")
  if ! find_match "$role" "$alias" >/dev/null; then
    fail "Listed role missing from agents_full/: $role"
  fi
done

shopt -s nullglob
listed_set=" ${listed_roles[*]} "
for path in agents/*; do
  base="$(basename "$path")"
  if [ "$base" = "ROLESET.md" ] || [ "$base" = "README.md" ]; then
    continue
  fi
  if [ ! -f "$path" ]; then
    fail "Unexpected entry in agents/: $base"
    continue
  fi
  alias=$(map_alias "$base")
  required=false
  case " $listed_set " in *" $base "*) required=true ;; esac
  if ! find_match "$base" "$alias" >/dev/null; then
    if [ "$required" = true ]; then
      fail "agents/$base does not have a matching file anywhere under agents_full/"
    else
      warn "agents/$base does not have a matching file anywhere under agents_full/ (custom?)"
    fi
  fi
  case "$base" in
    *.md) ;;
    *) fail "agents/ contains non-markdown file: $base" ;;
  esac
done
shopt -u nullglob

check_ascii "README.md"
check_ascii "AGENTS.md"
check_ascii "COMMUNICATION.md"
check_ascii "$ROLESET"
for file in agents/*.md; do
  check_ascii "$file"
done

if (( status == 0 )); then
  echo "OK: agents verification passed"
else
  echo "FAIL: agents verification failed"
fi

exit $status
