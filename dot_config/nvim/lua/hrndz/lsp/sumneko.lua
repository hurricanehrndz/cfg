local lspconfig = require("lspconfig")

local root_path = ""
local binary = ""

root_path = vim.fn.getenv("HOME") .. "/.cache/nvim/lua-language-server/"
if vim.fn.has("mac") == 1 then
  binary = root_path .. "bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
  binary = root_path .. "bin/Linux/lua-language-server"
else
  print("Unsupported system for sumneko")
end


local M = {}
M.setup = function(on_attach, capabilities)
  local has_luadev, luadev = pcall(require, "lua-dev")
  if not has_luadev then
    return
  end
  local luadev_config = luadev.setup({
    lspconfig = {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { binary, "-E", root_path .. "main.lua" },
    }
  })
  lspconfig.sumneko_lua.setup(luadev_config)
end

return M
