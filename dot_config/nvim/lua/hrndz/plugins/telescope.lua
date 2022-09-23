local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = " ",
    -- layout_strategy = "center",
    -- layout_config = {
    --   height = 0.3,
    --   width = 0.8,
    -- },
    -- sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      anchor = "N",
      mirror = true,
      height = 0.8,
      width = 0.8,
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("dap")
telescope.load_extension("notify")

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
  f = {
    name = "Find",
    w = { "<Cmd>Telescope grep_string<CR>", "Find string" },
    g = { "<Cmd>Telescope live_grep<CR>", "Find text" },
    f = { find_files, "Find files" },
    h = { "<cmd>Telescope help_tags<CR>", "Help" },
    n = { "<cmd>Telescope notify<CR>", "Notifications" },
    b = { find_buffers, "Find buffer" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
  },
}, { prefix = "<space>" })

local plenary_ft = require("plenary.filetype")
plenary_ft.add_file("defs")
