# CLAUDE.md
## Repository Structure

This is a dotfiles repo that symlinks config files to the home directory.

- `shell/` - Shell config files (zshrc, gitconfig, etc.) → symlinked as `~/.{filename}`
- `claude/` - Global Claude Code config → symlinked into `~/.claude/`
- `nvim/` - Neovim config → symlinked as `~/.config/nvim`.
- `symlink_script.sh` - Sets up all symlinks

Note that ./claude/ is the repository of files that should be symlinked into ~/.claude/ but then locally in this repo, there is ./.claude/ which is the project-level configurations for Claude Code.

vimium is an extension for Chrome that enables vim-style keybindings. That should not symlinked anywhere, it is here so that any changes can be copied and pasted manually into the chrome extension settings.

## Setup

Run `./symlink_script.sh` to create symlinks. The script:
1. Links each file in `shell/*` to `~/.{filename}`
2. Links each item in `claude/*` to `~/.claude/{name}`
3. Links `nvim/` to `~/.config/nvim`
4. Creates `~/iCloud` and `~/programming` shortcuts

The Neovim config also needs `brew install fzf fd ripgrep` (used by fzf-lua).

## Testing Changes

Shell config changes require reloading: `source ~/.zshrc`

Neovim changes require restarting nvim or `:source $MYVIMRC`

## Usage
- Note that because the files are symlinked, you do not need to ask tool permission for files like ~/.claude/settings.json or ~/.zshrc. Instead, simply run the tool on the local version of those files claude/settings.json or shell/zshrc, respectively, for example.
