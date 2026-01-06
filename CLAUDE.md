# CLAUDE.md
## Repository Structure

This is a dotfiles repo that symlinks config files to the home directory.

- `shell/` - Shell config files (zshrc, vimrc, gitconfig, etc.) → symlinked as `~/.{filename}`
- `claude/` - Global Claude Code config → symlinked into `~/.claude/`
- `symlink_script.sh` - Sets up all symlinks, also installs Vundle for vim

Note that ./claude/ is the repository of files that should be symlinked into ~/.claude/ but then locally in this repo, there is ./.claude/ which is the project-level configurations for Claude Code.

vimium is an extension for Chrome that enables vim-style keybindings. That should not symlinked anywhere, it is here so that any changes can be copied and pasted manually into the chrome extension settings.

## Setup

Run `./symlink_script.sh` to create symlinks. The script:
1. Links each file in `shell/*` to `~/.{filename}`
2. Links each item in `claude/*` to `~/.claude/{name}`
3. Clones Vundle for vim plugin management
4. Creates `~/iCloud` and `~/programming` shortcuts

## Testing Changes

Shell config changes require reloading: `source ~/.zshrc`

Vim changes require restarting vim or `:source ~/.vimrc`
