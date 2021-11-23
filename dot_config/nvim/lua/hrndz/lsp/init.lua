local has_astronauta, _ = pcall(require, 'astronauta.keymap')
if not has_astronauta then
  return
end

local nnoremap = vim.keymap.nnoremap
local inoremap = vim.keymap.inoremap

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end


local buf_nnoremap = function(opts)
  opts.buffer = 0
  nnoremap(opts)
end

local buf_inoremap = function(opts)
  opts.buffer = 0
  inoremap(opts)
end

local custom_attach = function(client)
  buf_nnoremap({ '[d', vim.diagnostic.goto_prev })
  buf_nnoremap({ ']d', vim.diagnostic.goto_next })
  buf_nnoremap({ 'ga', vim.lsp.buf.code_action })
  buf_nnoremap({ 'gd', vim.lsp.buf.definition })
  buf_nnoremap { 'gD', vim.lsp.buf.declaration }
  buf_nnoremap { 'gy', vim.lsp.buf.type_definition }
  buf_nnoremap { 'gr', vim.lsp.buf.references }
  buf_nnoremap { 'gR', vim.lsp.buf.rename }
  buf_nnoremap { 'K', vim.lsp.buf.hover }

  buf_inoremap { "<c-m>", vim.lsp.buf.signature_help }
  buf_nnoremap { '<c-m>', vim.lsp.buf.signature_help }
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

-- Setup lspconfig.
local has_lsp, lspconfig = pcall(require, 'lspconfig')
local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not has_lsp or not has_cmp_lsp then
  return
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = cmp_lsp.update_capabilities(updated_capabilities)


local has_nlua, nlua = pcall(require, 'nlua.lsp.nvim')
if has_nlua then
  nlua.setup(lspconfig, {
    on_init = custom_init,
    on_attch = custom_attach,
    capabilities = updated_capabilities,
  })
end

-- javascript
local ts_utils_settings = {
    -- debug = true,
    enable_import_on_completion = true,
    import_all_scan_buffers = 100,
    update_imports_on_move = true,
    -- filter out dumb module warning
    filter_out_diagnostics_by_code = { 80001 },
}
lspconfig.tsserver.setup({
    on_init = custom_init,
    init_options = require("nvim-lsp-ts-utils").init_options,
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup(ts_utils_settings)
        ts_utils.setup_client(client)
        custom_attach(client)
    end,
})

local eslint_opts = {
  condition = function(utils)
    return utils.root_has_file(".eslintrc.js")
  end,
  diagnostics_format = "#{m} [#{c}]",
}
local null_ls = require("null-ls")
local b = null_ls.builtins
local sources = {
    b.formatting.prettier.with({
        disabled_filetypes = { "typescript", "typescriptreact" },
    }),
    b.diagnostics.eslint_d.with(eslint_opts),
    b.formatting.eslint_d.with(eslint_opts),
    b.code_actions.eslint_d.with(eslint_opts),
    b.formatting.shfmt,
    b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
    b.hover.dictionary,
}
null_ls.config({
  sources = sources,
})
require("lspconfig")["null-ls"].setup({ on_attach = custom_attach })
