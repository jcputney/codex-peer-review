#!/bin/bash
# Stop hook: Remind Claude to verify peer review was performed when needed

cat << 'EOF'
## Peer Review Verification

Before completing this response, verify:

**Did this response include any of these?**
- Implementation plan or design proposal
- Code review findings
- Architecture recommendation
- Answer to a broad technical question
- Major refactoring suggestion

**If YES:** Did you dispatch to the `codex-peer-review:codex-peer-reviewer` agent for validation?

**If you forgot:** Consider whether the response would benefit from peer review before the user acts on it. You can still invoke the peer review agent now.

**If peer review was skipped intentionally:** That's fine for trivial tasks, quick questions, or when the user explicitly declined.
EOF
