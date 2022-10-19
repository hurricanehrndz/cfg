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

telescope.setup({
  extensions = {
    file_browser = {
      initial_mode = "normal",
      layout_strategy = "horizontal",
      sorting_strategy = "ascending",
      layout_config = {
        mirror = false,
        height = 0.9,
        prompt_position = "top",
        preview_cutoff = 120,
        width = 0.9,
        preview_width = 0.55,
      },
    },
  },
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
  --[[   pickers = {
    find_files = {
      find_command = {
        "rg",
        "--no-binary",
        "--files",
      },
    },
  } ,]]
})

telescope.load_extension("fzf")
telescope.load_extension("dap")
telescope.load_extension("notify")
telescope.load_extension("file_browser")

local find_files = function()
  ts_builtin.find_files()
end

local find_buffers = function()
  ts_builtin.buffers(dropdown_no_preview)
end

local file_browser = function()
  ---@diagnostic disable-next-line: param-type-mismatch
  telescope.extensions.file_browser.file_browser({ path = vim.fn.expand("%:p:h", false, false) })
end

local map = require("hrndz.utils").map

map("n", "<space>fw", "<Cmd>Telescope grep_string<CR>", "Find string")
map("n", "<space>fg", "<Cmd>Telescope live_grep<CR>", "Find text")
map("n", "<space>ff", find_files, "Find files")
map("n", "<space>fF", "<Cmd>Telescope git_files<CR>", "Find git files")
map("n", "<space>fh", "<cmd>Telescope help_tags<CR>", "Help")
map("n", "<space>fn", "<cmd>Telescope notify<CR>", "Notifications")
map("n", "<space>fb", find_buffers, "Find buffer")
map("n", "<space>fr", "<cmd>Telescope oldfiles<cr>", "Recent File")
map("n", "<space>fR", "<cmd>Telescope registers<cr>", "Registers")
map("n", "<space>fe", file_browser, "Open Explorer")
map("n", "<space>fc", "<cmd>Telescope commands<cr>", "Commands")

local plenary_ft = require("plenary.filetype")
plenary_ft.add_file("defs")
