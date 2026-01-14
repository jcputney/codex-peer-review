# Codex Peer Review

A Claude Code plugin that provides peer validation using OpenAI Codex CLI. Two AI perspectives catch more issues than one.

## Overview

This plugin validates Claude's designs, code reviews, and recommendations by getting a second opinion from OpenAI's Codex CLI before presenting them to users. When disagreements occur, a structured discussion protocol resolves them, with Perplexity as the final arbiter for persistent conflicts.

## Features

- **Automatic Peer Review**: The skill auto-triggers before Claude presents implementation plans, code reviews, or architecture recommendations
- **Structured Disagreement Resolution**: 2-round discussion protocol with evidence-based arguments
- **Perplexity Arbitration**: Expert escalation for unresolved disputes or security concerns
- **Slash Command**: Explicit `/codex-peer-review` command for on-demand validation

## Installation

### As a Plugin

```bash
# Add this marketplace
/plugin marketplace add jcputney/codex-peer-review

# Install the plugin
/plugin install codex-peer-review
```

### Prerequisites

**Account Requirements:**
- **Claude Code**: Requires a Claude Pro ($20/mo), Max, Team Premium, or Enterprise subscription
- **OpenAI Codex CLI**: Included with ChatGPT Plus/Pro/Business/Edu/Enterprise plans, or use OpenAI API credits

**Install Codex CLI:**

```bash
# Install Codex CLI
npm i -g @openai/codex

# Authenticate (opens browser for OAuth or prompts for API key)
codex login
```

## Usage

### Automatic Mode

The plugin automatically triggers peer review when Claude is about to present:
- Implementation plans or designs
- Code review results
- Architecture recommendations
- Major refactoring proposals
- Answers to broad technical questions

### Slash Command

```bash
# Review current changes against default branch
/codex-peer-review

# Review against specific branch
/codex-peer-review --base develop

# Validate answer to a broad question
/codex-peer-review "Should we use microservices or monolith for this project?"
```

## How It Works

1. **Claude Forms Opinion**: Claude analyzes the task and forms a recommendation
2. **Dispatch to Codex**: A subagent runs Codex CLI to get a second opinion
3. **Compare Findings**: Results are classified as agreement, disagreement, or complement
4. **Resolution**:
   - **Agreement**: Synthesize and present combined view
   - **Disagreement**: Enter 2-round discussion protocol
   - **Persistent Conflict**: Escalate to Perplexity for arbitration

### Command Selection

| Validation Type | Codex Command | Use When |
|-----------------|---------------|----------|
| Code Review | `codex review --base X` | Reviewing actual code changes (diffs) |
| Design Validation | `codex exec "..."` | Validating proposals, plans, architecture |
| Question Answering | `codex exec "..."` | Answering broad technical questions |

## Plugin Structure

```
codex-peer-review/
├── .claude-plugin/
│   ├── plugin.json           # Plugin metadata
│   └── marketplace.json      # Marketplace registry
├── agents/
│   └── codex-peer-reviewer.md  # Subagent that runs peer review in isolated context
├── skills/
│   └── codex-peer-review/
│       ├── SKILL.md          # Protocol reference (loaded by agent)
│       ├── discussion-protocol.md
│       ├── escalation-criteria.md
│       └── common-mistakes.md
├── commands/
│   └── codex-peer-review.md  # Slash command (dispatches to agent)
├── hooks/
│   └── peer-review-reminder.sh  # SessionStart hook
└── README.md
```

## Architecture

**Key Design:** All Codex CLI work runs in a **subagent context** to keep the main conversation clean.

```
Main Conversation                    Subagent Context
       │                                    │
       │ 1. Claude forms opinion            │
       │                                    │
       ├──── dispatch to agent ────────────►│
       │                                    │ 2. Run codex review/exec
       │                                    │ 3. Compare findings
       │                                    │ 4. Discussion rounds (if needed)
       │                                    │ 5. Escalate (if needed)
       │◄──── return synthesized result ────┤
       │                                    │
       │ 6. Present to user                 │
       ▼                                    ▼
```

The subagent loads the `codex-peer-review` skill for protocol reference, runs all Codex CLI commands, and returns only the final synthesized result.

## Configuration

The plugin creates a SessionStart hook that reminds Claude about the peer review requirement at the beginning of each session.

## Contributing

Contributions are welcome! Please ensure any changes maintain the language-agnostic nature of the prompts and examples.

## License

MIT

## Related Resources

- [Claude Code Documentation](https://code.claude.com/docs)
- [OpenAI Codex CLI](https://github.com/openai/codex)
- [Claude Code Plugins Guide](https://code.claude.com/docs/en/plugins)

---

**Why two AIs?** Every analysis has blind spots. A second perspective from a different AI model catches issues that a single model might normalize or overlook. This peer validation approach provides higher-quality recommendations to users.
