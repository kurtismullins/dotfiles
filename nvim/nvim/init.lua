--
-- External Dependencies:
---- ripgrep
---- https://github.com/sharkdp/fd
--
require('packages')


-- Leader Key (Space)
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


