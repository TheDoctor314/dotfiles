local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=false }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', [[<cmd>lua require('fzf-lua').lsp_definitions()<CR>]], opts)
  buf_set_keymap('n', 'gd', [[<cmd>lua require('fzf-lua').lsp_definitions()<CR>]], opts)
  buf_set_keymap('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>li', [[<cmd>lua require('fzf-lua').lsp_implementations()<CR>]], opts)
  buf_set_keymap('n', '<leader>ls', [[<cmd>lua require('fzf-lua').grep_curbuf()<CR>]], opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lt', [[<cmd>lua require('fzf-lua').lsp_typedefs()<CR>]], opts)
  buf_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', [[<cmd>lua require('fzf-lua').lsp_code_actions()<CR>]], opts)
  buf_set_keymap('n', '<leader>lx', [[<cmd>lua require('fzf-lua').lsp_references()<CR>]], opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', [[<cmd>lua require('fzf-lua').lsp_document_diagnostics()<CR>]], opts)
  buf_set_keymap('n', '<space>s', [[<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>]], opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
end

-- Enable some language servers with the capabilities offered by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities();

-- Do not forget to use the on_attach function
nvim_lsp.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

local rt = require('rust-tools')

rt.setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                },
                checkOnSave = {
                    command = "clippy",
                    target = {
                        "x86_64-unknown-linux-gnu",
                        "wasm32-unknown-unknown",
                    }
                },
            },
        },
    },
    tools = {
        inlay_hints = {
            only_current_line = true,
        },
    },
})

-- nvim_lsp.rust_analyzer.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--         ["rust-analyzer"] = {
--             cargo = {
--                 allFeatures = true,
--             },
--             checkOnSave = {
--                 command = "clippy",
--             },
--         },
--     },
-- }

-- Show line diagnostics in hover window
-- NOTE: This setting is global and should only be set once
vim.o.updatetime = 500
vim.cmd [[autocmd CursorHoldI * lua vim.diagnostic.open_float({scope="l"})]]

---- Disable the virtual text for diagnostics
--vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--    virtual_text = false,
--    update_in_insert = true,
--})
