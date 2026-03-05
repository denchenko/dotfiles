local root = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), "\n", "")

-- Fast saving
vim.keymap.set('n', '<CR>', ':write!<CR>')
vim.keymap.set('n', '<Leader>q', ':q!<CR>', { silent = true })

-- HOP
vim.keymap.set('n', '<leader><leader>p', '<cmd>:HopPattern<CR>')
vim.keymap.set('n', '<leader><leader>w', '<cmd>:HopWord<CR>')

-- Some useful quickfix shortcuts for quickfix
vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-m>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>a', '<cmd>cclose<CR>')

-- Exit on jj and jk
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Exit on jj and jk
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', 'jk', '<ESC>')

-- Remove search highlight
vim.keymap.set('n', '<Leader><BS>', ':nohlsearch<CR>')

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
vim.keymap.set('n', 'n', 'nzzzv', {noremap = true})
vim.keymap.set('n', 'N', 'Nzzzv', {noremap = true})

-- Don't jump forward if I higlight and search for a word
local function stay_star()
  local sview = vim.fn.winsaveview()
  local args = string.format("keepjumps keeppatterns execute %q", "sil normal! *")
  vim.api.nvim_command(args)
  vim.fn.winrestview(sview)
end
vim.keymap.set('n', '*', stay_star, {noremap = true, silent = true})

-- We don't need this keymap, but here we are. If I do a ctrl-v and select
-- lines vertically, insert stuff, they get lost for all lines if we use
-- ctrl-c, but not if we use ESC. So just let's assume Ctrl-c is ESC.
vim.keymap.set('i', '<C-c>', '<ESC>')

-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the
-- clipboard
vim.keymap.set("x", "p", "\"_dP")

-- rename the word under the cursor
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Better split switching
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')

-- Visual linewise up and down by default (and use gj gk to go quicker)
vim.keymap.set('n', '<Up>', 'gk')
vim.keymap.set('n', '<Down>', 'gj')

-- Yanking a line should act like D and C
vim.keymap.set('n', 'Y', 'y$')

-- Terminal
-- Close terminal window, even if we are in insert mode
vim.keymap.set('t', '<leader>q', '<C-\\><C-n>:q<cr>')

-- switch to normal mode with esc
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')

-- Open terminal in vertical and horizontal split
vim.keymap.set('n', '<leader>tv', '<cmd>vnew term://' .. vim.o.shell .. '<CR>', { noremap = true })
vim.keymap.set('n', '<leader>ts', '<cmd>split term://' .. vim.o.shell .. '<CR>', { noremap = true })

-- Open terminal in vertical and horizontal split, inside the terminal
vim.keymap.set('t', '<leader>tv', '<c-w><cmd>vnew term://' .. vim.o.shell .. '<CR>', { noremap = true })
vim.keymap.set('t', '<leader>ts', '<c-w><cmd>split term://' .. vim.o.shell .. '<CR>', { noremap = true })

-- mappings to move out from terminal to other views
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')

-- we don't use netrw (because of nvim-tree), hence re-implement gx to open
-- links in browser
vim.keymap.set("n", "gx", '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>')

-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFile!<CR>', { noremap = true })

-- vim-test
vim.keymap.set('n', '<leader>tt', ':TestNearest -v<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tf', ':TestFile -v<CR>', { noremap = true, silent = true })

-- dap
local dapui = require('dapui')
vim.keymap.set('n', '<leader>dbg', dapui.toggle, {})

local dap = require('dap')
vim.keymap.set('n', '<leader>sb', dap.toggle_breakpoint, {})

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-b>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>td', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, {})
vim.keymap.set('n', '<leader>lg', function()
  builtin.live_grep({ cwd = root })
end)
vim.keymap.set('n', '<leader>lc', function()
  builtin.grep_string({ cwd = root })
end)

-- diagnostics
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>ds', vim.diagnostic.setqflist)

-- vim-go
local function build_go_files()
  if vim.endswith(vim.api.nvim_buf_get_name(0), "_test.go") then
    vim.cmd("GoTestCompile")
  else
    vim.cmd("GoBuild")
  end
end
vim.keymap.set('n', '<leader>b', build_go_files)

-- diagnostics config: no inline text, show as float on hover
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  float = { border = "rounded" },
})
