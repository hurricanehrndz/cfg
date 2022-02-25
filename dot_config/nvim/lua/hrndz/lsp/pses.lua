local M = {}

M.setup = function(on_attach, capabilities)
  local lspconfig = require("lspconfig")
  lspconfig["powershell_es"].setup({
    bundle_path = vim.fn.getenv("HOME") .. "/.cache/nvim/PSES/",
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
