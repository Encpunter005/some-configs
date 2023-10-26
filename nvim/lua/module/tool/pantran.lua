require("pantran").setup {
    -- Default engine to use for translation. To list valid engine names run
    -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
    default_engine = "google",
    -- Configuration for individual engines goes here.
    engines = {
        google = {
            -- Default languages can be defined on a per engine basis. In this case
            -- `:lua require("pantran.async").run(function()
            -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
            -- can be used to list available language identifiers.
            default_source = "auto",
            default_target = "zh",
        },
    },
}

