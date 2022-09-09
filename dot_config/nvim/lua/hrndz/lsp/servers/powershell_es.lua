local M = {}

M.setup = function(on_attach, capabilities)
  local lspconfig = require("lspconfig")
  lspconfig["powershell_es"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
