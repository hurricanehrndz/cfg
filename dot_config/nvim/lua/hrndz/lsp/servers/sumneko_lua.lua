local M = {}

M.setup = function(on_attach, capabilities)
  local lspconfig = require("lspconfig")
  local has_neodev, neodev = pcall(require, "neodev")
  if not has_neodev then
    return
  end
  neodev.setup({
    override = function(root_dir, library)
      local chezmoi_dir = vim.fn.expandcmd("~/.local/share/chezmoi")
      if require("neodev.util").has_file(root_dir, chezmoi_dir) then
        library.enabled = true
        library.plugins = true
        library.types = true
        library.runtime = true
      end
    end,
  })
  lspconfig.sumneko_lua.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
