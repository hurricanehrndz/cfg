local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local ts_builtin = require("telescope.builtin")
local themes = require("telescope.themes")
local dropdown_no_preview = themes.get_dropdown({
  previewer = false,
  initial_mode = "normal",
  layout_config = {
    width = function(_, max_columns, _)
      return math.min(max_columns - 10, 110)
    end,
    height = function(_, _, max_lines)
      return math.min(max_lines - 10, 25)
    end,
  },
})
--[[ local center_input = {
  winblind = 10,
  layout_strategy = "vertical",
  layout_config = {
    preview_cutoff = 40,
    mirror = true,
    height = 0.9,
    width = 0.8,
  },
  border = true,
  borderchars = {
    prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
    results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  },
} ]]

telescope.setup({
  defaults = {
    prompt_prefix = "  ",
    selection_caret = " ",
    layout_strategy = "vertical",
    layout_config = {
      preview_cutoff = 40,
      mirror = true,
      height = 0.9,
      width = 0.8,
    },
    border = true,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
  },
  pickers = {
    find_files = {
      find_command = {
        "rg",
        "--no-ignore",
        "--hidden",
        "--no-binary",
        "--iglob",
        "!.git/*",
        "--iglob",
        "!.git-crypt/*",
        "--files",
      },
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("dap")
telescope.load_extension("notify")

local find_files = function()
  ts_builtin.find_files()
end

local find_buffers = function()
  ts_builtin.buffers(dropdown_no_preview)
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
