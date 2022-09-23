---@diagnostic disable-next-line: missing-parameter
local mini = vim.fn.glob(vim.fn.stdpath("data") .. "**/mini.lua")
if mini == "" then
  return
end

require("mini.ai").setup({})
require("mini.align").setup({})
require("mini.misc").setup({})
require("mini.surround").setup({})
require("mini.trailspace").setup({})
