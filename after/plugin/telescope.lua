require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<C-h>"] = "which_key",
                ["jk"] = require("telescope.actions").close
            }
        }
    },
    pickers = {
        find_command = {
            "fd"

        }
    },
}
-- builting pickers
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Lists files in your current working directory, respects .gitignore" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Lists open buffers in current neovim instance" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Lists available help tags" })
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = "Lists available plugin/user commands" })
vim.keymap.set('n', '<leader>fp', builtin.builtin, { desc = "Lists the builtin pickers" })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Lists normal mode keymappings" })
vim.keymap.set('n', '<leader>fs', builtin.spell_suggest, { desc = "Lists spelling suggestions for the current word under the cursor, replaces word with selected suggestion" })
vim.keymap.set('n', '<leader>ft', builtin.filetypes, { desc = "Lists all available filetypes" })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Change git branch' })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Lists git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h' })
vim.keymap.set('n', '<leader>gC', builtin.git_bcommits, { desc = 'Lists buffer\'s git commits with diff preview and checks them out on <cr>' })

-- custom pickers
local custom = require("ewood.telescope-config")

vim.keymap.set('n', '<leader><leader>', custom.project_files, { desc = 'Fuzzy search through the output of `git ls-files` command, respects .gitignore' })

-- treesitter pickers
vim.keymap.set('n', '<leader>s', builtin.treesitter, { desc = 'Lists Function names, variables, from Treesitter' })
