-- This is where all the plugins go, like the code blocks in here, just
-- stick everything like seen and the plugins should just work
-- Ideally stick your functions on 1 line if you can
-- If you need multiple then fine
--
local vim = vim
local Plug = vim.fn['plug#']

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug('catppuccin/nvim', { as = 'catppuccin' })

vim.call('plug#end')

-- Telescope setup (REQUIRED for Telescope to work)
require('telescope').setup()

-- Catppuccin setup (REQUIRED for colorscheme to work)
require('catppuccin').setup()

-- Set the colorscheme (REQUIRED to actually apply it)
vim.cmd.colorscheme('catppuccin')
