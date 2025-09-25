#!/usr/bin/env bash
set -euo pipefail
ROOT_AGENTS="AGENTS.md"
[ -f "$ROOT_AGENTS" ] || { echo "Missing $ROOT_AGENTS"; exit 1; }
MISSING=0
# Parse Role Registry lines that include → `path`
AGENTS=$(sed -n 's/.*→ `\(.*\)`/\1/p' "$ROOT_AGENTS")
if [ -z "${AGENTS}" ]; then
  echo "No roles found in Role Registry — verify section ## 8 exists."
  exit 1
fi
for f in $AGENTS; do
  if [ ! -f "$f" ]; then echo "Missing role doc: $f"; MISSING=1; fi
done
exit $MISSING
