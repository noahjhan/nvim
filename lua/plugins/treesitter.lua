return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",  -- Run TSUpdate to update Treesitter parsers
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "c", "cpp", "lua", "go" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-h>",
        },
      },
    }
  end
}

