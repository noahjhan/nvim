return {
    {
        'sbdchd/neoformat',
        config = function()
            vim.g.neoformat_enabled_c = { "clangformat" }
            vim.g.neoformat_enabled_cpp = { "clangformat" }

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
                command = "Neoformat"
            })
        end,
    }
}
