# Coding Preferences

- Use `rm -f` flag when removing files
- No comments unless specifically asked - code should be self-explanatory
- No argument validation at function start
- No try-catch unless explicitly asked
- Make minimal changes when fixing issues - don't refactor unrelated code

# Git Workflow

- `gh` is aliased to `git hist`, so use `command gh` for GitHub CLI
- Prefer rebase over merge when updating feature branches from master/main
- Name worktrees as `{repo-name}--{branch-name}`

# Process

- Update CLAUDE.md after significant code changes
- Write out purpose before running bash scripts
- Reflect on tool results before proceeding

# Running Bash Commands
- When specifying a path, use paths relative to the current working directory, rather than absolute paths.
- There is no need to cd into the local directory. Instead, first check your current working directory. If it is the repo's directory, then run the command. 
- When running commands, unless there is a specific reason to combine stderr and stdout using `2>&1`, don't do it.
