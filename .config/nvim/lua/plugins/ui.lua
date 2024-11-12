return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local utils = require("lualine.utils.utils")
            -- Try to pick appropriate colors from the current theme.
            local colors = {
                normalBg = utils.extract_color_from_hllist("bg", { "Normal" }, "#000000"),
                normalFg = utils.extract_color_from_hllist("fg", { "Normal" }, "#000000"),
                insertBg = utils.extract_color_from_hllist("bg", { "Cursor" }, "#000000"),
                insertFg = utils.extract_color_from_hllist("fg", { "Cursor" }, "#000000"),
                visualBg = utils.extract_color_from_hllist("bg", { "Visual" }, "#000000"),
                visualFg = utils.extract_color_from_hllist("fg", { "Visual" }, "#000000"),
                commandBg = utils.extract_color_from_hllist("bg", { "CurSearch" }, "#000000"),
                commandFg = utils.extract_color_from_hllist("fg", { "CurSearch" }, "#000000"),
                statusBg = utils.extract_color_from_hllist("bg", { "StatusLine" }, "#000000"),
                statusFg = utils.extract_color_from_hllist("fg", { "StatusLine" }, "#000000"),
                inactiveBg = utils.extract_color_from_hllist("bg", { "StatusLineNC" }, "#000000"),
                inactiveFg = utils.extract_color_from_hllist("fg", { "StatusLineNC" }, "#000000"),
            }
            require("lualine").setup({
                options = {
                    theme = {
                        normal = {
                            a = { bg = colors.normalFg, fg = colors.normalBg, gui = "bold" },
                            b = { bg = colors.statusBg, fg = colors.statusFg },
                            c = { bg = colors.statusBg, fg = colors.statusFg },
                        },
                        insert = {
                            a = { bg = colors.insertBg, fg = colors.insertFg, gui = "bold" },
                        },
                        replace = {
                            a = { bg = colors.insertBg, fg = colors.insertFg, gui = "bold" },
                        },
                        visual = {
                            a = { bg = colors.visualBg, fg = colors.visualFg, gui = "bold" },
                        },
                        command = {
                            a = { bg = colors.commandBg, fg = colors.commandFg, gui = "bold" },
                        },
                        inactive = {
                            c = { bg = colors.inactiveBg, fg = colors.inactiveFg },
                        },
                    },
                    component_separators = "|",
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        { "mode", separator = { left = "", right = "" }, padding = 2 },
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
            })
        end,
    },
    {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
}
