local M = {}

M.setup = function(on_init, on_attach, capabilities)
  local has_nlua, nlua = pcall(require, 'nlua.lsp.nvim')
  if has_nlua then
    nlua.setup(require('lspconfig'), {
      on_init = on_init,
      on_attch = on_attach,
      capabilities = capabilities,
    })
  end
end

return M
