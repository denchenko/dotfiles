-- automatically switch to insert mode when entering a Term buffer
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
    group = vim.api.nvim_create_augroup("openTermInsert", {}),
    callback = function(args)
        -- we don't use vim.startswith() and look for test:// because of vim-test
        -- vim-test starts tests in a terminal, which we want to keep in normal mode
        if vim.endswith(vim.api.nvim_buf_get_name(args.buf), "fish") then
            vim.cmd("startinsert")
        end
    end,
})

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})

-- don't show number
vim.api.nvim_create_autocmd("TermOpen", {
    command = [[setlocal nonumber norelativenumber]]
})

-- Go uses gofmt, which uses tabs for indentation and spaces for aligment.
-- Hence override our indentation rules.
vim.api.nvim_create_autocmd('Filetype', {
  group = vim.api.nvim_create_augroup('setIndent', { clear = true }),
  pattern = { 'go' },
  command = 'setlocal noexpandtab tabstop=4 shiftwidth=4'
})

-- Run gofmt/gofmpt, import packages automatically on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('setGoFormatting', { clear = true }),
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end

    vim.lsp.buf.format()
  end
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', '<leader>v', "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', '<leader>s', "<cmd>belowright split | lua vim.lsp.buf.definition()<CR>", opts)

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

-- automatically resize all vim buffers if I resize the terminal window
vim.api.nvim_command('autocmd VimResized * wincmd =')

-- https://github.com/neovim/neovim/issues/21771
local exitgroup = vim.api.nvim_create_augroup('setDir', { clear = true })
vim.api.nvim_create_autocmd('DirChanged', {
  group = exitgroup,
  pattern = { '*' },
  command = [[call chansend(v:stderr, printf("\033]7;file://%s\033\\", v:event.cwd))]],
})

vim.api.nvim_create_autocmd('VimLeave', {
  group = exitgroup,
  pattern = { '*' },
  command = [[call chansend(v:stderr, "\033]7;\033\\")]],
})

-- show diagnostics float on CursorHold
vim.api.nvim_create_autocmd('CursorHold', {
  group = vim.api.nvim_create_augroup('DiagnosticFloat', { clear = true }),
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- put quickfix window always to the bottom
local qfgroup = vim.api.nvim_create_augroup('changeQuickfix', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = qfgroup,
  command = 'wincmd J',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = qfgroup,
  command = 'setlocal wrap',
})
