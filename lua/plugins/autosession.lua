return {
    [1] = "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppressed_dirs = { "/", "~/", "~/Downloads", "~/Documents/github" },
        -- log_level = 'debug',
    },
}
