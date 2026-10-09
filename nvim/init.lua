vim.g.mapleader = ' '

local opt = vim.opt
local map = vim.keymap.set

vim.pack.add({
  'https://github.com/kien/ctrlp.vim',
  'https://github.com/tpope/vim-surround',
  'https://github.com/tpope/vim-endwise',
  'https://github.com/mkitt/tabline.vim',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/sheerun/vim-polyglot',
  'https://github.com/Lokaltog/vim-distinguished',
  'https://github.com/morhetz/gruvbox',
  'https://github.com/vim-test/vim-test',
  'https://github.com/coder/claudecode.nvim',
}, { confirm = false })

vim.g['test#strategy'] = 'basic'
vim.g['test#javascript#vitest#options'] = '--run'
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*/e2e/*',
  callback = function() vim.b.test_runner = 'playwright' end,
})
map('n', '<leader>a', '<cmd>TestSuite<cr>')
map('n', '<leader>t', '<cmd>TestFile<cr>')
map('n', '<leader>s', '<cmd>TestNearest<cr>')

-- Ignore certains directories for ctrl-p
vim.g.ctrlp_custom_ignore = [[deps\|node_modules]]

vim.cmd.colorscheme('gruvbox')

require('claudecode').setup()
map('n', '<leader>c', '<cmd>ClaudeCode<cr>')

vim.filetype.add({
  extension = { prawn = 'ruby', axlsx = 'ruby' },
  pattern = { ['.*%.json%.jbuilder'] = 'ruby' },
})

-- Enable text wrapping for Markdown files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.md', '*.txt' },
  callback = function() vim.opt_local.wrap = true end,
})

opt.rulerformat = '%60(%f:%l of %L%)'

-- Highlight cursor line
opt.cursorline = true

-- New panes should open below and to the right, which is more intuitive
opt.splitbelow = true
opt.splitright = true

-- prevents vim from creating a separate backup file.
opt.backup = false
opt.writebackup = false

-- prevents vim from creating a separate swap file, which tends to get in the way of git.
opt.swapfile = false

-- get rid of highlighting after you are done with searching
map('', '<leader>h', '<cmd>nohlsearch<cr>')

-- search ignores case iff all letters in search field are lower case.
-- otherwise, it will be case-sensitive
opt.ignorecase = true
opt.smartcase = true

-- there will always be X lines of context above and below your cursor.
opt.scrolloff = 10

-- tab increments by two spaces
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Display extra whitespace
opt.list = true
opt.listchars = { tab = '··', trail = '·' }

-- Text does not wrap at edge of file
opt.wrap = false

-- Create ruler, with width of 1
opt.numberwidth = 1

-- set line numbers to be relative by default
opt.relativenumber = true
opt.number = true

map('', '<leader>l', function()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
  elseif vim.wo.number then
    vim.wo.number = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
  end
end)

-- smartindent is off because it interferes with the endwise plugin

-- movement keys always move cursor to start of a line.
opt.startofline = true

-- set default explorer style to be tree
vim.g.netrw_liststyle = 3

-- hide DS_Store files in netrw
vim.g.netrw_list_hide = [[.*\.DS_Store$]]

map('', '<leader>k', '<cmd>Ex<cr>')

-- backspace deletes characters
map('', '<backspace>', 'X')

-- switch splits and make full-screen
map('', '<leader>q', '<c-w>w<c-w>|')

-- make current split full-screen
map('', '<leader>w', '<c-w>|')

-- make current screens equal size
map('', '<leader>e', '<c-w>=')

-- open new vertical split
map('', '<leader>v', '<cmd>Vex<cr><c-w>=')

-- open new horizontal split
map('', '<leader>b', '<cmd>Sex<cr><c-w>=')

-- enter a new line without going into insert mode
map('', '<leader><cr>', 'o<esc>')

-- being typing shell commands
map('', '<leader>i', ':!')

-- Common mistaken keys for saving and quitting
for _, cmd in ipairs({ 'W', 'Q', 'WQ', 'Wq' }) do
  vim.api.nvim_create_user_command(cmd, cmd:lower() .. '<bang>', { bang = true })
end
map('ca', 'wQ', function()
  return (vim.fn.getcmdtype() == ':' and vim.fn.getcmdline() == 'wQ') and 'wq' or 'wQ'
end, { expr = true })

-- vim tab management
map('', '<S-Tab>', 'gT')
map('', '<tab>', 'gt')
map('', '<leader><tab>', '<cmd>Texplore<cr>')

-- Capital Y should be yanking the whole line
map({ 'n', 'o' }, 'Y', 'yy')
map('x', 'Y', ':yank<cr>')
