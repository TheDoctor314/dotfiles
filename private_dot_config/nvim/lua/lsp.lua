-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { buf = bufnr }
  vim.keymap.set('n', 'gD', FzfLua.lsp_definitions, opts)
  vim.keymap.set('n', 'gd', FzfLua.lsp_definitions, opts)
  vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>li', FzfLua.lsp_implementations, opts)
  vim.keymap.set('n', '<leader>ls', FzfLua.grep_curbuf, opts)
  vim.keymap.set('n', '<leader>lt', FzfLua.lsp_typedefs, opts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', FzfLua.lsp_code_actions, opts)
  vim.keymap.set('n', '<leader>lx', FzfLua.lsp_references, opts)
  -- vim.keymap.set('n', '<space>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.jump({count = -1, float = true}) end, opts)
  vim.keymap.set('n', ']d', function() vim.diagnostic.jump({count = 1, float = true}) end, opts)
  vim.keymap.set('n', '<leader>ld', FzfLua.lsp_document_diagnostics, opts)
  vim.keymap.set('n', '<space>s', FzfLua.lsp_document_symbols, opts)
  vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts)
end

-- Enable language servers with the capabilities offered by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities();
vim.lsp.config('*', {
    capabilities = capabilities,
})

-- Do not forget to use the on_attach function
vim.lsp.config('clangd', {
    on_attach = on_attach,
})
vim.lsp.enable('clangd')

vim.g.rustaceanvim = {
    server = {
        on_attach = on_attach,
    }
}

if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true)
end

-- Show line diagnostics in hover window
-- NOTE: This setting is global and should only be set once
vim.o.updatetime = 500
vim.cmd [[autocmd CursorHoldI * lua vim.diagnostic.open_float({scope="l"})]]

---- Disable the virtual text for diagnostics
--vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--    virtual_text = false,
--    update_in_insert = true,
--})
