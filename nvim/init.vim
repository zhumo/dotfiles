set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
lua vim.pack.add({ "https://github.com/coder/claudecode.nvim" }, { confirm = false })
lua require("claudecode").setup()
