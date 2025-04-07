return {
    {
        "nvim-telescope/telescope.nvim",
        name = "telescope",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        end
    }
}

