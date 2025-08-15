vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"

vim.opt.smartindent = true
vim.opt.wrap = false

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.o.number = true
    vim.o.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.o.number = true
    vim.o.relativenumber = true
  end,
})

vim.api.nvim_create_user_command('Config', function()
  vim.cmd('cd ' .. vim.fn.expand('~') .. '/.config/nvim') 
  vim.cmd('e .')  
end, {})

vim.api.nvim_create_user_command('Rat', function()
  vim.cmd('cd ' .. vim.fn.expand('~') .. '/github_projects/rat')  
  vim.cmd('e .')  
end, {})

vim.api.nvim_create_user_command('Spimbot', function()
  vim.cmd('cd ' .. vim.fn.expand('~') .. '/cs233/spimbot')  
  vim.cmd('e .')  
end, {})

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
    pattern = { "*" },
    callback = function()
        if vim.opt.buftype:get() == "terminal" then
            vim.cmd(":startinsert")
        end
    end
})
