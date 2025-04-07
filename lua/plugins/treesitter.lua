return {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",  -- Run TSUpdate to update Treesitter parsers
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "cpp", -- Install only maintained parsers
            highlight = {
                enable = true, -- Enable Treesitter-based syntax highlighting
                disable = {}, -- List of languages to disable highlighting for
            },
            indent = {
                enable = true, -- Enable Treesitter-based indentation
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<CR>", -- Start selection
                    node_incremental = "<CR>", -- Increment selection
                    scope_incremental = "<C-s>", -- Increment selection by scope
                    node_decremental = "<C-h>", -- Decrement selection
                },
            },
        })
    end
}

