# Project Conventions

This is a Claude Code plugin marketplace for AI-to-AI peer review.

## Architecture

- **Subagent Pattern**: All Codex CLI work runs in a separate subagent context to prevent context pollution
- **Advisory Hooks**: Hooks remind Claude to run peer review but don't enforce it
- **Marketplace Structure**: Designed to host multiple peer review plugins

## File Organization

```
.claude-plugin/marketplace.json  # Marketplace registry
plugins/
  codex-peer-review/
    .claude-plugin/plugin.json   # Plugin metadata
    agents/                      # Subagent definitions
    commands/                    # Slash commands
    skills/                      # Skill documentation
    hooks/                       # Lifecycle hooks
```

## Writing Guidelines

### Prompts and Skills
- Keep all prompts **language-agnostic** - examples should work for any programming language
- Use `codex exec` for validating designs/plans, `codex review` only for actual diffs
- Always document both the happy path and error handling

### Shell Scripts
- Use `cat << 'EOF'` (quoted) for heredocs with special characters
- Inject variables separately with `echo` after the heredoc
- Handle the case where Codex CLI is not installed

### Documentation
- Be accurate about what hooks do (remind vs enforce)
- Include all supported command options
- Keep the README structure diagram updated

## Command Selection

| Scenario | Command |
|----------|---------|
| Reviewing code changes | `codex review --base X` |
| Validating designs/plans | `codex exec "..."` |
| Answering questions | `codex exec "..."` |

## Testing Changes

1. Install the plugin locally: `/plugin add /path/to/codex-peer-review`
2. Test the `/codex-peer-review` command
3. Verify hooks display correctly at session start
4. Check subagent dispatch works
