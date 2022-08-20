local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.load_extension("fzf")

local opts = { noremap = true, silent = true }

-- string maps
-- search for current word under cursor
vim.keymap.set("n", "<space>fw", function()
  return require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>", nil, nil) })
end)
vim.keymap.set("n", "<space>fs", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<space>fg", require("telescope.builtin").live_grep)

-- file finder
vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files)
vim.keymap.set(
  "n",
  "<space>ff",
  function()
    return require("telescope.builtin").find_files({
      prompt_prefix = "🔍",
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
    })
  end,
  opts
)

-- buffer finder
vim.keymap.set(
  "n",
  "<M-b>",
  function()
    return require("telescope.builtin").buffers(
      require('telescope.themes').get_dropdown({
        previewer = false,
        initial_mode = 'normal'
      })
    )
  end,
  opts
)

-- help finder
vim.keymap.set("n", "<M-/>", require("telescope.builtin").help_tags)

local plenary_ft = require("plenary.filetype")
plenary_ft.add_file("defs")
