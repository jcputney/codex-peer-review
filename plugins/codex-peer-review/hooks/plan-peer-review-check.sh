#!/bin/bash
# PreToolUse hook for ExitPlanMode: Remind to peer review the plan

cat << 'EOF'
## Peer Review Check - Before Presenting Plan

You are about to present an implementation plan to the user.

**STOP and verify:** Has this plan been validated by the `codex-peer-review:codex-peer-reviewer` agent?

Plans that should be peer reviewed:
- Multi-step implementation plans
- Architecture decisions
- Significant refactoring proposals
- Security-sensitive changes
- Performance-critical designs

**If not yet reviewed:** Dispatch to the peer review agent BEFORE calling ExitPlanMode.

**If already reviewed or not applicable:** Proceed with ExitPlanMode.
EOF
