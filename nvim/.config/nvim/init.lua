require("config.lazy")
-- define clipboard
vim.opt.clipboard = "unnamedplus"
-- my custom theme
vim.cmd("colorscheme 95-1")
-- enable python lsp
vim.lsp.enable('pylsp')
-- enable mini.pairs
require('mini.pairs').setup()
