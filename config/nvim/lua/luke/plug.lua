-- This is where all the plugins go, like the code blocks in here, just
-- stick everything like seen and the plugins should just work
-- Ideally stick your functions on 1 line if you can
-- If you need multiple then fine
--
-- Telescope setup
require('telescope').setup(require('telescope.themes').get_dropdown())

-- Catppuccin setup
require('catppuccin').setup()
vim.cmd.colorscheme('catppuccin')

-- Neo-tree setup (pass empty config table)
require('neo-tree').setup({})
