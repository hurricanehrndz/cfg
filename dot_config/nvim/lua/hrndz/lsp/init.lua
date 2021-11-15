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
  buf_nnoremap({ 'gd', vim.lsp.buf.definition })
  buf_nnoremap { 'gD', vim.lsp.buf.declaration }
  buf_nnoremap { 'gT', vim.lsp.buf.type_definition }
  buf_nnoremap { 'gr', vim.lsp.buf.references }
  buf_nnoremap { 'gR', vim.lsp.buf.rename }
  buf_nnoremap { 'K', vim.lsp.buf.hover }

  buf_inoremap { "<c-m>", vim.lsp.buf.signature_help }
  buf_nnoremap { '<c-m>', vim.lsp.buf.signature_help }
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
if not has_nlua then
  return
end
nlua.setup(lspconfig, {
  on_init = custom_init,
  on_attch = custom_attach,
  capabilities = updated_capabilities,
})
