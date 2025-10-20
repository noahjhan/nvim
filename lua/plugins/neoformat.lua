return {
    {
        'sbdchd/neoformat',
        config = function()
            -- Enable formatters
            vim.g.neoformat_enabled_c = { "clangformat" }
            vim.g.neoformat_enabled_cpp = { "clangformat" }
            vim.g.neoformat_enabled_go = { "gofmt" }      -- Go formatter
            vim.g.neoformat_enabled_lua = { "stylua" }    -- Lua formatter

            -- Autoformat on save for C, C++, Go, Lua, and header files
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.go", "*.lua" },
                command = "Neoformat"
            })
        end,
    }
}

