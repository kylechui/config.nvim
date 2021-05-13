vim.cmd [[packadd nvim-web-devicons]]
local gl = require('galaxyline')
local utils = require('utils')
local condition = require('galaxyline.condition')
local diagnostic = require('galaxyline.provider_diagnostic')

local gls = gl.section
gl.short_line_list = {'packer', 'NvimTree', 'Outline', 'LspTrouble'}

local colors = {
    bg = '#1D2021',
    fg = '#D4BE98',
    section_bg = '#3C3836',
    red1 = '#EA6962',
    red2 = '#BE5046',
    orange = '#E78A4E',
    yellow = '#D8A657',
    green = '#8EC07C',
    blue = '#7DAEA3',
    purple = '#D3869B',
    grey1 = '#5C6370',
    grey2 = '#2C323D',
    grey3 = '#3E4452',
    grey = '#848586',
    middlegrey = '#8791A5',
    darkgrey = '#5C6370'
}

-- Local helper functions
local buffer_not_empty = function() return not utils.is_buffer_empty() end

local checkwidth = function()
    return utils.has_width_gt(35) and buffer_not_empty()
end

local function has_value(tab, val)
    for _, value in ipairs(tab) do if value[1] == val then return true end end
    return false
end

local mode_color = function()
    local mode_colors = {
        [110] = colors.green,
        [105] = colors.blue,
        [99] = colors.green,
        [116] = colors.blue,
        [118] = colors.purple,
        [22] = colors.purple,
        [86] = colors.purple,
        [82] = colors.red1,
        [115] = colors.red1,
        [83] = colors.red1
    }

    local color = mode_colors[vim.fn.mode():byte()]
    if color ~= nil then
        return color
    else
        return colors.purple
    end
end

local function file_readonly()
    if vim.bo.filetype == 'help' then return '' end
    if vim.bo.readonly == true then return '  ' end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand('%:t')
    if vim.fn.empty(file) == 1 then return '' end
    if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
    if vim.bo.modifiable then
        if vim.bo.modified then return file .. '  ' end
    end
    return file .. ' '
end

-- local function trailing_whitespace()
--     local trail = vim.fn.search('\\s$', 'nw')
--     if trail ~= 0 then
--         return '  '
--     else
--         return nil
--     end
-- end

-- local function tab_indent()
--     local tab = vim.fn.search('^\\t', 'nw')
--     if tab ~= 0 then
--         return ' → '
--     else
--         return nil
--     end
-- end

-- local function buffers_count()
--     local buffers = {}
--     for _, val in ipairs(vim.fn.range(1, vim.fn.bufnr('$'))) do
--         if vim.fn.bufexists(val) == 1 and vim.fn.buflisted(val) == 1 then
--             table.insert(buffers, val)
--         end
--     end
--     return #buffers
-- end

local function get_basename(file) return file:match('^.+/(.+)$') end

local GetGitRoot = function()
    local git_dir = require('galaxyline.provider_vcs').get_git_dir()
    if not git_dir then return '' end

    local git_root = git_dir:gsub('/.git/?$', '')
    return get_basename(git_root..' ')
end

local LspStatus = function()
    if #vim.lsp.get_active_clients() > 0 then
        return require'lsp-status'.status()
    end
    return ''
end

local LspCheckDiagnostics = function()
    if #vim.lsp.get_active_clients() > 0 and diagnostic.get_diagnostic_error() ==
        nil and diagnostic.get_diagnostic_warn() == nil and
        diagnostic.get_diagnostic_info() == nil and require'lsp-status'.status() ==
        ' ' then return ' ' end
    return ''
end

-- Left side
gls.left[1] = {
    ViMode = {
        provider = function()
            local aliases = {
                [110] = 'NORMAL',
                [105] = 'INSERT',
                [99] = 'COMMAND',
                [116] = 'TERMINAL',
                [118] = 'VISUAL',
                [22] = 'V-BLOCK',
                [86] = 'V-LINE',
                [82] = 'REPLACE',
                [115] = 'SELECT',
                [83] = 'S-LINE'
            }
            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
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
            return '  ' .. mode .. ' '
        end,
        highlight = {colors.section_bg, colors.section_bg, 'bold'}
    }
}
gls.left[2] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = buffer_not_empty,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg
        }
    }
}
gls.left[3] = {
    FileName = {
        provider = get_current_file_name,
        highlight = {colors.fg, colors.section_bg},
    }
}

gls.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = '+',
        highlight = {colors.green, colors.bg},
        separator = ' ',
        separator_highlight = {colors.bg, colors.section_bg}
    }
}
gls.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '~',
        highlight = {colors.orange, colors.section_bg}
    }
}
gls.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '-',
        highlight = {colors.red1, colors.section_bg}
    }
}
gls.right[4] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {colors.section_bg, colors.section_bg}
    }
}
gls.right[5] = {
    GitBranch = {
        provider = {function() return '  ' end, 'GitBranch'},
        condition = condition.check_git_workspace,
        highlight = {colors.middlegrey, colors.section_bg}
    }
}
gls.right[6] = {
    GitRoot = {
        provider = {GetGitRoot},
        condition = function()
            return utils.has_width_gt(50) and condition.check_git_workspace
        end,
        highlight = {colors.fg, colors.bg},
        separator = ' ',
        separator_highlight = {colors.middlegrey, colors.section_bg}
    }
}
--[[ gls.right[7] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = {'NONE', colors.section_bg, 'bold'},
        highlight = {colors.fg, colors.section_bg},
    }
} ]]

gls.right[8] = {
    WordCount = {
        provider = {
            function()
                if (vim.fn.mode() == 'v' or vim.fn.mode() == 'V') then
                  return string.format(' %sW ', vim.fn.wordcount().visual_words)
                else
                  return string.format(' %sW ', vim.fn.wordcount().words)
                end
            end
        },
        separator = ' |',
        separator_highlight = {colors.bg, colors.section_bg, 'bold'},
        highlight = {colors.red1, colors.section_bg}
    }
}
gls.right[9] = {
    LineInfo = {
        provider = {
            function()
                return string.format(' %s:%s ', vim.fn.line('.'), vim.fn.col('.'))
            end
        },
        separator = '|',
        separator_highlight = {colors.bg, colors.section_bg, 'bold'},
        highlight = {colors.blue, colors.section_bg}
    }
}

gls.right[10] = {
    PerCent = {
        provider = 'LinePercent',
        separator = '|',
        separator_highlight = {colors.bg, colors.section_bg, 'bold'},
        highlight = {colors.green, colors.section_bg}
    }
}

-- Short status line
gls.short_line_left[1] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = function()
            return buffer_not_empty and
                       has_value(gl.short_line_list, vim.bo.filetype)
        end,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg
        }
    }
}
gls.short_line_left[2] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = {colors.yellow, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
