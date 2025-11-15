vim.opt.nu = true
vim.opt.relativenumber = true
 
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
 
vim.opt.smartindent = true
 
vim.opt.wrap = false
 
vim.opt.swapfile = false
vim.opt.backup = false
 
vim.opt.hlsearch = true
vim.opt.incsearch = true
 
vim.opt.scrolloff = 15
 
vim.opt.updatetime = 50
vim.opt.termguicolors = true

vim.cmd "spell! spelllang=en_gb"
 
vim.cmd "set path+=**"

-- Global: Visual wrapping for all files
vim.opt.wrap = true           -- Visual wrapping at window edge
vim.opt.linebreak = true      -- Break at words
vim.opt.breakindent = true    -- Maintain indent on wrapped lines

-- Filetype-specific: Hard wrapping for text/markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'gitcommit' },
  callback = function()
    vim.opt_local.textwidth = 100      -- Hard wrap at 100 chars
    vim.opt_local.formatoptions = 't'  -- Auto-wrap when typing
    vim.opt_local.colorcolumn = "120"  -- Visual guide at wrap point
  end
})

-- Optional: Disable hard wrap for code files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'python', 'javascript', 'typescript' },
  callback = function()
    vim.opt_local.textwidth = 0        -- No hard wrapping
    vim.opt_local.colorcolumn = "1000000000000"  -- But still show guide
  end
})
