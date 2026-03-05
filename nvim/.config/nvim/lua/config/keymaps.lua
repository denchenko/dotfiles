local root = vim.fn.getcwd()
do
  local out = vim.fn.system("git rev-parse --show-toplevel")
  if vim.v.shell_error == 0 then
    root = string.gsub(out, "\n", "")
  end
end

-- Fast saving
vim.keymap.set('n', '<CR>', ':write!<CR>')
vim.keymap.set('n', '<Leader>q', ':q!<CR>', { silent = true, desc = "Quit window" })

-- HOP
vim.keymap.set('n', '<leader><leader>p', '<cmd>:HopPattern<CR>', { desc = "Hop pattern" })
vim.keymap.set('n', '<leader><leader>w', '<cmd>:HopWord<CR>', { desc = "Hop word" })

-- Some useful quickfix shortcuts for quickfix
vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-m>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>a', '<cmd>cclose<CR>', { desc = "Close quickfix" })

-- Exit on jj and jk
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Exit on jj and jk
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', 'jk', '<ESC>')

-- Remove search highlight
vim.keymap.set('n', '<Leader><BS>', ':nohlsearch<CR>', { desc = "Clear search highlight" })

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
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

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
vim.keymap.set('n', '<leader>tv', '<cmd>vnew term://' .. vim.o.shell .. '<CR>', { noremap = true, desc = "Terminal vertical" })
vim.keymap.set('n', '<leader>ts', '<cmd>split term://' .. vim.o.shell .. '<CR>', { noremap = true, desc = "Terminal horizontal" })

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
vim.keymap.set("n", "gx", function()
  vim.ui.open(vim.fn.expand("<cfile>"))
end, { desc = "Open URL/file under cursor" })

-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, desc = "Toggle file tree" })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFile!<CR>', { noremap = true, desc = "Find file in tree" })

-- vim-test
vim.keymap.set('n', '<leader>tt', ':TestNearest -v<CR>', { noremap = true, silent = true, desc = "Test nearest" })
vim.keymap.set('n', '<leader>tf', ':TestFile -v<CR>', { noremap = true, silent = true, desc = "Test file" })

-- dap
local dapui = require('dapui')
vim.keymap.set('n', '<leader>dbg', dapui.toggle, { desc = "Toggle debug UI" })

local dap = require('dap')
vim.keymap.set('n', '<leader>sb', dap.toggle_breakpoint, { desc = "Toggle breakpoint" })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Find git files" })
vim.keymap.set('n', '<C-b>', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<C-g>', builtin.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { desc = "LSP implementations" })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = "LSP references" })
vim.keymap.set('n', '<leader>td', builtin.diagnostics, { desc = "Telescope diagnostics" })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git status" })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Git branches" })
vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, { desc = "Git buffer commits" })
vim.keymap.set('n', '<leader>lg', function()
  builtin.live_grep({ cwd = root })
end, { desc = "Live grep (root)" })
vim.keymap.set('n', '<leader>lc', function()
  builtin.grep_string({ cwd = root })
end, { desc = "Grep word under cursor" })

-- diagnostics
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set('n', '<leader>ds', vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

-- go build/test-compile
local function build_go_files()
  local cmd
  if vim.endswith(vim.api.nvim_buf_get_name(0), "_test.go") then
    cmd = { "go", "test", "-run", "^$", "./..." }
  else
    cmd = { "go", "build", "./..." }
  end
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stderr = function(_, data)
      if data and data[1] ~= "" then
        vim.schedule(function() vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR) end)
      end
    end,
    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          vim.notify("Build succeeded", vim.log.levels.INFO)
        end
      end)
    end,
  })
end
vim.keymap.set('n', '<leader>b', build_go_files, { desc = "Go build/test-compile" })

-- diagnostics config: no inline text, show as float on hover
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  float = { border = "rounded" },
})
