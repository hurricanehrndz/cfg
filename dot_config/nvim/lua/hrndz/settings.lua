local bo = require("hrndz.lib.bufopts")
local wo = vim.wo
local o = vim.o
local g = vim.g

-- Disable python plugin support
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.filetype_pp = "puppet"
g.hrnd_theme = "tokyonight"

-- >> window-scoped options <<--
-- show line numbers
wo.number = true
-- show relative numbers
wo.relativenumber = true
-- always have sign column
wo.signcolumn = "yes"
-- disable line wrap
wo.wrap = false
-- enable color column
wo.colorcolumn = "120"

-- >> edior options <<--
-- cursor
o.guicursor = ""
-- abandon buffer when unloading
o.hidden = true
-- refresh rate of diagnostic msg
o.updatetime = 300
-- split new window below current
o.splitbelow = true
-- split new window right of current
o.splitright = true
-- case insensitive search
o.ignorecase = true
-- highlight searches
o.hlsearch = true
-- copy-paste with system clipboard, no copy to unnamed on put (*)
o.clipboard = "unnamed,unnamedplus"
-- some language servers don't like backup files
o.backup = false
o.writebackup = false
-- scrolling "bounding"
o.scrolloff = 5
o.sidescrolloff = 10
-- strings to use in list command for punctuation
o.listchars = [[tab:→ ,eol:↲,space:␣,trail:•,extends:⟩,precedes:⟨]]
-- set max with of text
o.textwidth = 120
-- set selection to exclusive
o.selection = "exclusive"
o.smartcase = true
-- enable undofile
o.undofile = true
-- round indent
o.shiftround = true

-- >> buffer-scoped options <<--
bo.shiftwidth = 4 -- smarttab enable by default, ts sts ignored
bo.expandtab = true
bo.smartindent = true
