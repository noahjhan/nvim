return {
    {
        "windwp/nvim-autopairs",
        name = "autopairs",
        config = function()
            require("nvim-autopairs").setup({ check_ts = true })
        end
    }
}

