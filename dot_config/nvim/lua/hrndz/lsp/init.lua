local nnoremap = vim.keymap.nnoremap
local vnoremap = vim.keymap.vnoremap
local inoremap = vim.keymap.inoremap

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
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
nlua.setup(require('lspconfig'), {
  on_init = custom_init,
  capabilities = updated_capabilities,
})
