local M = {
  setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")

    lspconfig.puppet.setup({
      on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = true
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    })
  end,
}

return M
