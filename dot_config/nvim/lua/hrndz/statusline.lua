local has_feline, _ = pcall(require, 'feline')
if not has_feline then
  return
end

local colors = {
    bg = '#282c34',
    fg = '#abb2bf',
    yellow = '#e0af68',
    cyan = '#56b6c2',
    darkblue = '#081633',
    green = '#98c379',
    orange = '#d19a66',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#61afef',
    red = '#e86671'
}

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = ' '
    elseif os == 'MAC' then
        icon = ' '
    else
        icon = ' '
    end
    return icon .. os
end

local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

local lsp_get_diag = function(str)
  local count = vim.lsp.diagnostic.get_count(0, str)
  return (count > 0) and ' '..count..' ' or ''
end

-- LuaFormatter off

local comps = {
    vi_mode = {
        left = {
            provider = function()
              return '  ' .. vi_mode_utils.get_vim_mode()
            end,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color(),
                    -- fg = colors.bg
                }
                return val
            end,
            right_sep = ' '
        },
        right = {
            -- provider = '▊',
            provider = '' ,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color()
                }
                return val
            end,
            left_sep = ' ',
            right_sep = ' '
        }
    },
    file = {
        info = {
            provider = 'file_info',
            file_modified_icon = '',
            hl = {
                fg = colors.blue,
                style = 'bold'
            }
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        type = {
            provider = 'file_type'
        },
        os = {
            provider = file_osinfo,
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        position = {
            provider = 'position',
            left_sep = ' ',
            hl = {
                fg = colors.cyan,
                -- style = 'bold'
            }
        },
    },
    left_end = {
        provider = function() return '' end,
        hl = {
            fg = colors.bg,
            bg = colors.blue,
        }
    },
    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold'
        }
    },
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = {
            fg = colors.blue,
            style = 'bold'
        }
    },
    diagnos = {
        err = {
            -- provider = 'diagnostic_errors',
            provider = function()
                return '' .. lsp_get_diag("Error")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Error') end,
            hl = {
                fg = colors.red
            }
        },
        warn = {
            -- provider = 'diagnostic_warnings',
            provider = function()
                return '' ..  lsp_get_diag("Warning")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Warning') end,
            hl = {
                fg = colors.yellow
            }
        },
        info = {
            -- provider = 'diagnostic_info',
            provider = function()
                return '' .. lsp_get_diag("Information")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Information') end,
            hl = {
                fg = colors.blue
            }
        },
        hint = {
            -- provider = 'diagnostic_hints',
            provider = function()
                return '' .. lsp_get_diag("Hint")
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('Hint') end,
            hl = {
                fg = colors.cyan
            }
        },
    },
    lsp = {
        name = {
            provider = 'lsp_client_names',
            -- left_sep = ' ',
            right_sep = ' ',
            icon = '  ',
            hl = {
                fg = colors.yellow
            }
        }
    },
    git = {
        branch = {
            provider = 'git_branch',
            icon = ' ',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            },
        },
        add = {
            provider = 'git_diff_added',
            hl = {
                fg = colors.green
            }
        },
        change = {
            provider = 'git_diff_changed',
            hl = {
                fg = colors.orange
            }
        },
        remove = {
            provider = 'git_diff_removed',
            hl = {
                fg = colors.red
            }
        }
    }
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.inactive[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info)
table.insert(components.active[3], comps.diagnos.err)
table.insert(components.active[3], comps.diagnos.warn)
table.insert(components.active[3], comps.diagnos.hint)
table.insert(components.active[3], comps.diagnos.info)
table.insert(components.active[3], comps.lsp.name)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.scroll_bar)
table.insert(components.active[3], comps.vi_mode.right)


-- TreeSitter
-- local ts_utils = require("nvim-treesitter.ts_utils")
-- local ts_parsers = require("nvim-treesitter.parsers")
-- local ts_queries = require("nvim-treesitter.query")
--[[ table.insert(components.active[2], {
  provider = function()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    return ("%d:%s [%d, %d] - [%d, %d]")
      :format(node:symbol(), node:type(), node:range())
  end,
  enabled = function()
    local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
    return ok and ts_parsers.has_parser()
  end
}) ]]

-- require'feline'.setup {}
require'feline'.setup {
    colors = { bg = colors.bg, fg = colors.fg },
    components = components,
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
        filetypes = {
            'packer',
            'NvimTree',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = {'terminal'},
        bufnames = {}
    }
}
-- local colors = {
--     bg = '#282c34',
--     fg = '#abb2bf',
--     darkblue = '#081633',
--     green = '#98c379',
--     red = '#e06c75',
--     yellow = '#e5c07b',
--     blue = '#61afef',
--     cyan = '#56b6c2',
--     orange = '#d19a66',
--     violet = '#c678dd',
--     magenta = '#c678dd',
-- }
-- local lsp = require 'feline.providers.lsp'
-- local vi_mode_utils = require 'feline.providers.vi_mode'

-- local vi_mode_colors = {
--     NORMAL = colors.green,
--     INSERT = colors.red,
--     VISUAL = colors.magenta,
--     OP = colors.green,
--     BLOCK = colors.blue,
--     REPLACE = colors.violet,
--     ['V-REPLACE'] = colors.violet,
--     ENTER = colors.cyan,
--     MORE = colors.cyan,
--     SELECT = colors.orange,
--     COMMAND = colors.green,
--     SHELL = colors.green,
--     TERM = colors.green,
--     NONE = colors.yellow
-- }

-- local icons = {
--     linux = ' ',
--     macos = ' ',
--     windows = ' ',

--     errs = ' ',
--     warns = ' ',
--     infos = ' ',
--     hints = ' ',

--     lsp = ' ',
--     git = ''
-- }

-- local function file_osinfo()
--     local os = vim.bo.fileformat:upper()
--     local icon
--     if os == 'UNIX' then
--         icon = icons.linux
--     elseif os == 'MAC' then
--         icon = icons.macos
--     else
--         icon = icons.windows
--     end
--     return icon .. os
-- end

-- local function lsp_diagnostics_info()
--     return {
--         errs = lsp.get_diagnostics_count('Error'),
--         warns = lsp.get_diagnostics_count('Warning'),
--         infos = lsp.get_diagnostics_count('Information'),
--         hints = lsp.get_diagnostics_count('Hint')
--     }
-- end

-- local function diag_enable(f, s)
--     return function()
--         local diag = f()[s]
--         return diag and diag ~= 0
--     end
-- end

-- local function diag_of(f, s)
--     local icon = icons[s]
--     return function()
--         local diag = f()[s]
--         return icon .. diag
--     end
-- end

-- local function vimode_hl()
--     return {
--         name = vi_mode_utils.get_mode_highlight_name(),
--         fg = vi_mode_utils.get_mode_color()
--     }
-- end

-- -- LuaFormatter off

-- local comps = {
--     vi_mode = {
--         left = {
--             provider = '▊',
--             hl = vimode_hl,
--             right_sep = ' '
--         },
--         right = {
--             provider = '▊',
--             hl = vimode_hl,
--             left_sep = ' '
--         }
--     },
--     file = {
--         info = {
--             provider = 'file_info',
--             hl = {
--                 fg = colors.blue,
--                 style = 'bold'
--             }
--         },
--         encoding = {
--             provider = 'file_encoding',
--             left_sep = ' ',
--             hl = {
--                 fg = colors.violet,
--                 style = 'bold'
--             }
--         },
--         type = {
--             provider = 'file_type'
--         },
--         os = {
--             provider = file_osinfo,
--             left_sep = ' ',
--             hl = {
--                 fg = colors.violet,
--                 style = 'bold'
--             }
--         }
--     },
--     line_percentage = {
--         provider = 'line_percentage',
--         left_sep = ' ',
--         hl = {
--             style = 'bold'
--         }
--     },
--     scroll_bar = {
--         provider = 'scroll_bar',
--         left_sep = ' ',
--         hl = {
--             fg = colors.blue,
--             style = 'bold'
--         }
--     },
--     diagnos = {
--         err = {
--             provider = diag_of(lsp_diagnostics_info, 'errs'),
--             left_sep = ' ',
--             enabled = diag_enable(lsp_diagnostics_info, 'errs'),
--             hl = {
--                 fg = colors.red
--             }
--         },
--         warn = {
--             provider = diag_of(lsp_diagnostics_info, 'warns'),
--             left_sep = ' ',
--             enabled = diag_enable(lsp_diagnostics_info, 'warns'),
--             hl = {
--                 fg = colors.yellow
--             }
--         },
--         info = {
--             provider = diag_of(lsp_diagnostics_info, 'infos'),
--             left_sep = ' ',
--             enabled = diag_enable(lsp_diagnostics_info, 'infos'),
--             hl = {
--                 fg = colors.blue
--             }
--         },
--         hint = {
--             provider = diag_of(lsp_diagnostics_info, 'hints'),
--             left_sep = ' ',
--             enabled = diag_enable(lsp_diagnostics_info, 'hints'),
--             hl = {
--                 fg = colors.cyan
--             }
--         },
--     },
--     lsp = {
--         name = {
--             provider = 'lsp_client_names',
--             left_sep = ' ',
--             icon = icons.lsp,
--             hl = {
--                 fg = colors.yellow
--             }
--         }
--     },
--     git = {
--         branch = {
--             provider = 'git_branch',
--             icon = icons.git,
--             left_sep = ' ',
--             hl = {
--                 fg = colors.violet,
--                 style = 'bold'
--             },
--         },
--         add = {
--             provider = 'git_diff_added',
--             hl = {
--                 fg = colors.green
--             }
--         },
--         change = {
--             provider = 'git_diff_changed',
--             hl = {
--                 fg = colors.orange
--             }
--         },
--         remove = {
--             provider = 'git_diff_removed',
--             hl = {
--                 fg = colors.red
--             }
--         }
--     }
-- }

-- local properties = {
--     force_inactive = {
--         filetypes = {
--             'NvimTree',
--             'dbui',
--             'packer',
--             'startify',
--             'fugitive',
--             'fugitiveblame'
--         },
--         buftypes = {'terminal'},
--         bufnames = {}
--     }
-- }

-- local components = {
--     left = {
--         active = {
--             comps.vi_mode.left,
--             comps.file.info,
--             comps.lsp.name,
--             comps.diagnos.err,
--             comps.diagnos.warn,
--             comps.diagnos.hint,
--             comps.diagnos.info
--         },
--         inactive = {
--             comps.vi_mode.left,
--             comps.file.info
--         }
--     },
--     mid = {
--         ACTIVE = {},
--         INACTIVE = {}
--     },
--     RIGHT = {
--         ACTIVE = {
--             COMPS.GIT.ADD,
--             COMPS.GIT.CHANGE,
--             COMPS.GIT.REMOVE,
--             COMPS.FILE.OS,
--             COMPS.GIT.BRANCH,
--             COMPS.LINE_PERCENTAGE,
--             COMPS.SCROLL_BAR,
--             COMPS.VI_MODE.RIGHT
--         },
--         INACTIVE = {}
--     }
-- }

-- -- LUAFORMATTER ON

-- REQUIRE'FELINE'.SETUP {
--     DEFAULT_BG = COLORS.BG,
--     DEFAULT_FG = COLORS.FG,
--     COMPONENTS = COMPONENTS,
--     PROPERTIES = PROPERTIES,
--     VI_MODE_COLORS = VI_MODE_COLORS
-- }

