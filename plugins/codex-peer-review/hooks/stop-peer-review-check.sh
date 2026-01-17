#!/bin/bash
# Stop hook: STRONGLY remind Claude to verify peer review was performed

cat << 'EOF'
## ⚠️ STOP - Peer Review Verification Required

**BEFORE you complete this response, answer these questions:**

### 1. Did your response include ANY of these?
- [ ] Implementation plan or design
- [ ] Code review findings
- [ ] Architecture recommendation
- [ ] Multi-file code changes
- [ ] Answer to "how should I..." or "what's the best way to..."

### 2. If YES to any above: Did you dispatch to `codex-peer-review:codex-peer-reviewer`?

**If NO - you MUST do one of these NOW:**
1. **Dispatch peer review:** Use Task tool with `subagent_type="codex-peer-review:codex-peer-reviewer"`
2. **Explain skip:** Add a note: "Skipping peer review because: [trivial change / user declined / already validated]"

### 3. Acceptable reasons to skip:
- Single-line fixes or typo corrections
- User explicitly said "skip peer review" or "just do it"
- Pure information lookup (no recommendations)
- Following up on already-reviewed work

**Do NOT proceed without either peer review or explicit justification.**
EOF
