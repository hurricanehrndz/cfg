local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = " ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
})

telescope.load_extension("fzf")
local files_cmd = table.concat({
  "rg",
  "--no-ignore",
  "--hidden",
  "--no-binary",
  "--iglob",
  "!.git/*",
  "--iglob",
  "!.git-crypt/*",
  "--files",
}, ",")
local find_files = string.format("<Cmd>Telescope find_files find_command=%s<CR>", files_cmd)
local find_buffers = function()
  local ts = require("telescope.builtin")
  local themes = require("telescope.themes")
  return ts.buffers(themes.get_dropdown({ previewer = false }))
end

local has_wk, wk = pcall(require, "which-key")
if not has_wk then
  return
end

wk.register({
  name = "Find",
  f = {
    w = { "<Cmd>Telescope grep_string<CR>", "Find string" },
    g = { "<Cmd>Telescope live_grep<CR>", "Find text" },
    f = { find_files, "Find files" },
    h = { "<cmd>Telescope help_tags<CR>", "Help" },
    b = { find_buffers, "Find buffer" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
  },
}, { prefix = "<space>" })

local plenary_ft = require("plenary.filetype")
plenary_ft.add_file("defs")
