-- Leader + pv opens Ex
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Yank to system clipboard
vim.keymap.set("n", "y", '"+y', { noremap = true, silent = true })
vim.keymap.set("v", "y", '"+y', { noremap = true, silent = true })

-- Paste from system clipboard
vim.keymap.set("n", "p", '"+p', { noremap = true, silent = true })
vim.keymap.set("v", "p", '"+p', { noremap = true, silent = true })

-- Delete to system clipboard
vim.keymap.set("n", "d", '"+d', { noremap = true, silent = true })
vim.keymap.set("v", "d", '"+d', { noremap = true, silent = true })

-- Paste/delete into black hole register
vim.keymap.set("x", "<leader>p", [["_d+P]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Escape in terminal mode to return to Normal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Centers cursor after scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
