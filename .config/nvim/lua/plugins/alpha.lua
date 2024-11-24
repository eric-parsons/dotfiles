return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.buttons.val = {
            dashboard.button("SPC f r", "󱑂  Recent"),
            dashboard.button("SPC SPC", "󰱼  Find File"),
            dashboard.button("SPC f s", "󱎸  Find String"),
            dashboard.button("SPC e e", "  Browse"),
            dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
            dashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
        }
        dashboard.section.header.val = {
            "⠀⠀⠀⣾⣿⣿⣿⣿⣦⡀⢸⣿⣿⣿⣿⠃⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⢸⣿⣿⣿⣿⡄⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⡿⢁⣿⣿⣿⣿⡇⠀⣸⣿⣿⣿⣿⣷⣄⠀⢀⣴⣿⣿⣿⣿⡟",
            "⠀⠀⠀⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠟⠸⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠀⠀⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠇⠘⠿⠿⠿⠿⠇⠀⠀⠀⠰⠿⠿⠿⠿⠿⠟⠀⠸⠿⠿⠿⠿⠀⠀⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠇",
            "⠀⠀⣴⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⠀⢠⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⡆⠀⣰⣶⣶⣶⡶⠀⠀⠀⣶⣶⣶⣶⡆⠀⣶⣶⣶⣶⣶⠀⢀⣶⣶⣶⣶⣶⡶⠀⠀⠀⣶⣶⣶⣶⡆⠀⢰⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⠀",
            "⠀⢰⣿⣿⣿⣿⠉⠻⣿⣿⣿⣿⣿⡟⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⣿⣿⣿⣿⠇⠀⠀⢸⣿⣿⣿⣿⠀⠀⢸⣿⣿⣿⣿⣧⣾⣿⣿⣿⣿⠟⠁⠀⠀⢸⣿⣿⣿⣿⠁⠀⣿⣿⣿⣿⠇⠙⢿⣿⠟⢹⣿⣿⣿⣿⡇⠀",
            "⠀⣾⣿⣿⣿⡟⠀⠀⢸⣿⣿⣿⣿⠃⢠⣿⣿⣿⣿⡿⠉⠉⠉⠉⠉⠉⠀⢸⣿⣿⣿⡿⠀⠀⠀⣿⣿⣿⣿⡇⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⠀⠀⠈⠁⠀⣼⣿⣿⣿⡿⠀⠀",
            "⢠⣿⣿⣿⣿⠁⠀⠀⣿⣿⣿⣿⡿⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⢸⣿⣿⣿⣷⣶⣶⣾⣿⣿⣿⡟⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⣸⣿⣿⣿⣿⠁⠀⣿⣿⣿⣿⡇⠀⠀⠀⠀⢰⣿⣿⣿⣿⠇⠀⠀",
            "⣼⣿⣿⣿⡏⠀⠀⢸⣿⣿⣿⣿⡇⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠈⠻⢿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡟⠀⢸⣿⣿⣿⣿⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⠀⠀⠀",
            "",
        }
        require("alpha").setup(dashboard.opts)
    end,
}
