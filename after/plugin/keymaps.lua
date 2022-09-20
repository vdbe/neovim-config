-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({'!'}, 'jk', [[<c-\><c-n>]], {
    desc = 'Exit to normal mode',
    noremap = true, silent = true
})

-- Move lines in visual mode with J/K
vim.keymap.set({'v'}, "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" } )
vim.keymap.set({'v'}, "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" } )

-- Copy to system clipboard
vim.keymap.set({'v', 'n'}, "<leader>y", "\"+y", { desc = "copy to clipboard" } )
vim.keymap.set({'n'}, "<leader>Y", "\"+Y", { desc = "copy line to clipboard" } )

-- Window navigation
vim.keymap.set({'n'}, '<leader>ww', '<cmd>wincmd w<CR>', { desc = "Focus window below/right if none top-left" } )
vim.keymap.set({'n'}, '<leader>wh', '<cmd>wincmd h<CR>', { desc = "Focus window right of current" } )
vim.keymap.set({'n'}, '<leader>wj', '<cmd>wincmd j<CR>', { desc = "Focus window below of current" } )
vim.keymap.set({'n'}, '<leader>wk', '<cmd>wincmd k<CR>', { desc = "Focus window above of current" } )
vim.keymap.set({'n'}, '<leader>wl', '<cmd>wincmd l<CR>', { desc = "Focus window left of current" } )
vim.keymap.set({'n'}, '<leader>wt', '<cmd>wincmd t<CR>', { desc = "Focus top left window" } )
vim.keymap.set({'n'}, '<leader>wb', '<cmd>wincmd b<CR>', { desc = "Focus bottom right window" } )
vim.keymap.set({'n'}, '<leader>wp', '<cmd>wincmd p<CR>', { desc = "Focus previous (last accessed window)" } )

-- Window movement
vim.keymap.set({'n'}, '<leader>wr', '<cmd>wincmd r<CR>', { desc = "Rotate windows downards/rightwards" } )
vim.keymap.set({'n'}, '<leader>wR', '<cmd>wincmd R<CR>', { desc = "Rotate windows upwards/leftwards" } )
vim.keymap.set({'n'}, '<leader>wx', '<cmd>wincmd x<CR>', { desc = "Exchange current window with next one" } )
vim.keymap.set({'n'}, '<leader>wH', '<cmd>wincmd H<CR>', { desc = "Move current window to the far left" } )
vim.keymap.set({'n'}, '<leader>wJ', '<cmd>wincmd J<CR>', { desc = "Move current window to the very bottom" } )
vim.keymap.set({'n'}, '<leader>wK', '<cmd>wincmd K<CR>', { desc = "Move current window to the very top" } )
vim.keymap.set({'n'}, '<leader>wL', '<cmd>wincmd L<CR>', { desc = "Move current window to the far right" } )
vim.keymap.set({'n'}, '<leader>wL', '<cmd>wincmd T<CR>', { desc = "Move current window to a new tab page" } )

-- Window resizing
-- TODO: Figure how how to use count in keybinds

-- Window spliting
vim.keymap.set({'n'}, '<leader>wv', '<cmd>vsplit<CR>', { desc = "Split window in two." } )
vim.keymap.set({'n'}, '<leader>ws', '<cmd>split<CR>', { desc = "Split window in two (vertically)." } )

-- Buffer navigation
-- TODO: desc
vim.keymap.set({'n'}, '<leader>bl', '<cmd>e#<CR>')
vim.keymap.set({'n'}, '<leader>bp', '<cmd>bprevious<CR>')
vim.keymap.set({'n'}, '<leader>bn', '<cmd>bnext<CR>')
vim.keymap.set({'n'}, '<leader>bd', '<cmd>bdelete<CR>')
