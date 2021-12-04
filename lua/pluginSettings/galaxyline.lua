local utils = require("utils")
local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

local colors = require("galaxyline.themes.colors").get_color

-- Left side
gls.left[2] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors("green"),
                i = colors("blue"),
                v = colors("magenta"),
                [""] = colors("magenta"),
                V = colors("magenta"),
                c = colors("magenta"),
                no = colors("green"),
                s = colors("orange"),
                S = colors("orange"),
                [""] = colors("orange"),
                ic = colors("blue"),
                R = colors("cyan"),
                Rv = colors("cyan"),
                cv = colors("red"),
                ce = colors("red"),
                r = colors("cyan"),
                rm = colors("cyan"),
                ["r?"] = colors("cyan"),
                ["!"] = colors("red"),
                t = colors("red"),
            }
            local aliases = {
                [110] = "NORMAL",
                [105] = "INSERT",
                [99] = "COMMAND",
                [116] = "TERMINAL",
                [118] = "VISUAL",
                [22] = "V-BLOCK",
                [86] = "V-LINE",
                [82] = "REPLACE",
                [115] = "SELECT",
                [83] = "S-LINE"
            }
            vim.api.nvim_command("hi GalaxyViMode guibg=" .. mode_color[vim.fn.mode()]())
            vim.api.nvim_command("hi GalaxyViMode guifg=" .. colors("bg")())
            local alias = aliases[vim.fn.mode():byte()]
            local mode
            if alias ~= nil then
                if utils.has_width_gt(35) then
                    mode = alias
                else
                    mode = alias:sub(1, 1)
                end
            else
                mode = vim.fn.mode():byte()
            end
            return "  " .. mode .. " "
        end,
        separator = " ",
        separator_highlight = { "NONE", colors("bg") },
    },
}

gls.left[4] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = { require("galaxyline.providers.fileinfo").get_file_icon_color, colors("bg") },
    },
}

gls.left[5] = {
    FileName = {
        provider = "FileName",
        condition = condition.buffer_not_empty,
        highlight = { colors("fg"), colors("bg"), "bold" },
    },
}

gls.left[8] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = { colors("red"), colors("bg") },
    },
}
gls.left[9] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = { colors("yellow"), colors("bg") },
    },
}

gls.left[10] = {
    DiagnosticHint = {
        provider = "DiagnosticHint",
        icon = "  ",
        highlight = { colors("cyan"), colors("bg") },
    },
}

gls.left[11] = {
    DiagnosticInfo = {
        provider = "DiagnosticInfo",
        icon = "  ",
        highlight = { colors("blue"), colors("bg") },
    },
}

gls.right[1] = {
    WordCount = {
        provider = {
            function()
                if (vim.fn.mode() == "v" or vim.fn.mode() == "V") then
                    return string.format(" %sW ", vim.fn.wordcount().visual_words)
                else
                    return string.format(" %sW ", vim.fn.wordcount().words)
                end
            end
        },
        highlight = { colors("red"), colors("bg") }
    }
}

gls.right[2] = {
    LineInfo = {
        provider = {
            function()
                return string.format(" %s:%s ", vim.fn.line("."), vim.fn.col("."))
            end
        },
        separator = "|",
        separator_highlight = { colors("fg"), colors("bg"), "bold" },
        highlight = { colors("blue"), colors("bg") }
    }
}

gls.right[3] = {
    PerCent = {
        provider = "LinePercent",
        separator = "|",
        separator_highlight = { colors("fg"), colors("bg"), "bold" },
        highlight = { colors("green"), colors("bg") }
    }
}

gls.right[4] = {
    GitIcon = {
        provider = function()
            return "  "
        end,
        condition = condition.check_git_workspace,
        separator = "|",
        separator_highlight = { colors("fg"), colors("bg"), "bold" },
        highlight = { colors("magenta"), colors("bg") },
    },
}

gls.right[5] = {
    GitBranch = {
        provider = "GitBranch",
        condition = condition.check_git_workspace,
        highlight = { colors("magenta"), colors("bg"), "bold" },
    },
}

gls.right[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = condition.hide_in_width,
        icon = "  ",
        highlight = { colors("green"), colors("bg") },
    },
}

gls.right[7] = {
    DiffModified = {
        provider = "DiffModified",
        condition = condition.hide_in_width,
        icon = " 柳",
        highlight = { colors("orange"), colors("bg") },
    },
}

gls.right[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = condition.hide_in_width,
        icon = "  ",
        highlight = { colors("red"), colors("bg") },
    },
}

gls.right[9] = {
    EmptySpace = {
        provider = function()
            return " "
        end,
        condition = condition.check_git_workspace,
        highlight = { colors("fg"), colors("bg") },
    },
}


gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = " ",
        separator_highlight = { "NONE", colors("bg") },
        highlight = { colors("blue"), colors("bg"), "bold" },
    },
}

gls.short_line_left[2] = {
    SFileName = {
        provider = "SFileName",
        condition = condition.buffer_not_empty,
        highlight = { colors("fg"), colors("bg"), "bold" },
    },
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = "BufferIcon",
        highlight = { colors("fg"), colors("bg") },
    },
}
