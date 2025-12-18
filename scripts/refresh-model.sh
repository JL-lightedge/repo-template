#!/usr/bin/env bash
set -euo pipefail

# Sync the local MODEL_VERSION from the central registry.
# Registry defaults can be overridden via env vars.
REGISTRY_REPO="${REGISTRY_REPO:-Connectria/gpt-model-registry}"
REGISTRY_REF="${REGISTRY_REF:-main}"
TARGET_FILE="${TARGET_FILE:-MODEL_VERSION}"
TMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo "Fetching MODEL_VERSION from $REGISTRY_REPO@$REGISTRY_REF..."

TOKEN="${REGISTRY_TOKEN:-${GITHUB_TOKEN:-}}"
AUTH_HEADER=()
if [ -n "${TOKEN:-}" ]; then
  AUTH_HEADER=(-H "Authorization: Bearer $TOKEN")
fi

REGISTRY_URL="https://api.github.com/repos/${REGISTRY_REPO}/contents/MODEL_VERSION?ref=${REGISTRY_REF}"
TMP_FILE="${TMP_DIR}/MODEL_VERSION"

# Use the GitHub API so private repos work with a token. We rely on the base64
# content response to avoid leaking the token in a URL.
HTTP_STATUS=$(curl -s -w "%{http_code}" -o "${TMP_FILE}.json" "${AUTH_HEADER[@]}" "$REGISTRY_URL")
if [ "$HTTP_STATUS" -ge 400 ]; then
  echo "Failed to fetch MODEL_VERSION (status $HTTP_STATUS). Ensure REGISTRY_TOKEN or GITHUB_TOKEN has read access to ${REGISTRY_REPO}."
  cat "${TMP_FILE}.json" || true
  exit 1
fi

if [ ! -s "${TMP_FILE}.json" ]; then
  echo "Registry response missing."
  exit 1
fi

CONTENT=$(python3 -c 'import base64, json, sys
data = json.load(open(sys.argv[1], "r"))
encoded = data.get("content")
if not encoded:
    sys.exit(1)
decoded = base64.b64decode(encoded).decode("utf-8")
if not decoded.endswith("\n"):
    decoded += "\n"
sys.stdout.write(decoded)' "${TMP_FILE}.json") || {
  echo "Failed to decode MODEL_VERSION content."
  exit 1
}

printf "%s" "$CONTENT" > "$TMP_FILE"

if [ -f "$TARGET_FILE" ] && cmp -s "$TMP_FILE" "$TARGET_FILE"; then
  echo "MODEL_VERSION is already up to date."
  exit 0
fi

mv "$TMP_FILE" "$TARGET_FILE"
echo "Updated $TARGET_FILE from registry."
