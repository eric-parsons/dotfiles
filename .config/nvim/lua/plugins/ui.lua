-- These are designed to work with my custom color scheme.
local colors = {
    pink = "#efb0a8",
    green = "#3a9b53",
    cyan = "#6bc6c0",
    orange = "#e37c16",
    red = "#dc5041",
    bg_dark = "#2d3133",
    fg_dark = "#2f2521",
    fg_light = "#f9d7bc",
    fg_disabled = "#7a7d7f",
}

return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = {
                    normal = {
                        a = { bg = colors.green, fg = colors.fg_dark, gui = "bold" },
                        b = { bg = colors.bg_dark, fg = colors.fg_light },
                        c = { bg = colors.bg_dark, fg = colors.fg_light },
                    },
                    insert = {
                        a = { bg = colors.pink, fg = colors.fg_dark, gui = "bold"  },
                        c = { bg = colors.pink, fg = colors.fg_dark },
                    },
                    visual = {
                        a = { bg = colors.cyan, fg = colors.fg_dark, gui = "bold"  },
                        c = { bg = colors.cyan, fg = colors.fg_dark },
                    },
                    command = {
                        a = { bg = colors.orange, fg = colors.fg_dark, gui = "bold"  },
                        c = { bg = colors.orange, fg = colors.fg_dark },
                    },
                    replace = {
                        a = { bg = colors.red, fg = colors.fg_light, gui = "bold"  },
                        c = { bg = colors.red, fg = colors.fg_light },
                    },
                    inactive = {
                        c = { bg = colors.bg_dark, fg = colors.fg_disabled }
                    },
                },
                component_separators = "|",
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = {
                    { "mode", separator = { left = "", right =  "" }, padding = 2 },
                },
                lualine_b = {
                    { "filename", "branch", padding = 2 },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    { "filetype", padding = 2 },
                },
                lualine_z = {
                    { "location", padding = 2 },
                },
            },
        },
    },
    {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
}

