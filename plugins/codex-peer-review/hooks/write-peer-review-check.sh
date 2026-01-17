#!/bin/bash
# PreToolUse hook for Write: Check if writing significant implementation files

# Get the file path from environment (if available)
FILE_PATH="${CLAUDE_TOOL_INPUT:-}"

# Check if writing implementation files (not config, not docs, not tests)
if echo "$FILE_PATH" | grep -qiE "\.(ts|js|py|go|rs|java|cpp|c|rb|swift|kt)$" && \
   ! echo "$FILE_PATH" | grep -qiE "(test|spec|\.config|\.d\.ts)"; then
  cat << 'EOF'
**Peer Review Check:** You're about to write implementation code.

If this is part of a larger implementation plan that hasn't been peer reviewed, consider:
1. Pausing to dispatch to `codex-peer-review:codex-peer-reviewer` with your design
2. Then proceeding with implementation after validation

Skip this if: trivial change, bug fix, or design was already peer reviewed.
EOF
fi
