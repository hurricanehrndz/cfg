-- Sensible defaults - mine
require("hrndz.options")

-- Install packer if required
require("hrndz.packer")

-- Setup colors
require("hrndz.theme")
require("hrndz.statusline")

-- Install plugins
require("hrndz.plugins")

-- Key mappings
require("hrndz.keymaps")

-- Auto Command Groups
require("hrndz.autocmds")

-- LSP config
require("hrndz.lsp")

local parse_cmd = vim.api.nvim_parse_cmd
_G.FrontMatterUpdateLastMod = function()
  ---@diagnostic disable-next-line: param-type-mismatch
  local filename = tostring(vim.fn.expand("%:p:h", false, false))
  if filename:find("src/me/notes") then
    local view = vim.fn.winsaveview()
    local mod_time = os.date("%Y-%m-%dT%H:%M:%S%z")
    local re = [[%%s/\v%s/%s/]]
    local cmd = parse_cmd(re:format([[^(lastmod:).*$]], [[\1 ]] .. mod_time), {})
    cmd.mods.silent = true
    vim.cmd(cmd)
    vim.fn.winrestview(view)
  end
end
