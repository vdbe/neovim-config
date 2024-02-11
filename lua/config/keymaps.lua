-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
local km = vim.keymap

-- stylua: ignore start

-- Remove keymaps
-- km.del({ "i", "x", "n", "s" }, "<C-s>")
-- km.del("n", "<C-h>")
-- km.del("n", "<C-j>")
-- km.del("n", "<C-k>")
-- km.del("n", "<C-l>")

-- Restore default <C-l> behaviour
-- https://github.com/neovim/neovim/blob/eb3fcf652bbcab01cd6d55a0e2c120c09cbe69d3/runtime/lua/vim/_editor.lua#L920
-- km.set("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>")

--
-- Personal keybinds
--

-- Exit with jk
km.set({ "!", "t" }, "jk", [[<c-\><c-n>]], { desc = "Exit to normal mode" })

-- Copy to system clipboard
km.set({ "v", "n" }, "<leader>y", '"+y', { desc = "copy to clipboard" })

-- Window navigation
km.set({ "n" }, "<leader>wh", "<C-W>h", { desc = "Go to left window", remap = true })
km.set({ "n" }, "<leader>wj", "<C-W>j", { desc = "Go to lower window", remap = true })
km.set({ "n" }, "<leader>wk", "<C-W>k", { desc = "Go to upper window", remap = true })
km.set({ "n" }, "<leader>wl", "<C-W>l", { desc = "Go to right window", remap = true })
km.set({ "n" }, "<leader>wp", "<C-W>p", { desc = "Go to previous window", remap = true })
km.set({ "n" }, "<leader>wt", "<C-W>t", { desc = "Go to top left window", remap = true })
km.set({ "n" }, "<leader>wb", "<C-W>b", { desc = "Go to bottom right window", remap = true })
km.set({ "n" }, "<leader>ww", "<C-W>w", { remap = true })

-- Window movement
km.set({ "n" }, "<leader>wH", "<C-W>H", { desc = "Move window left", remap = true })
km.set({ "n" }, "<leader>wJ", "<C-W>J", { desc = "Move window down", remap = true })
km.set({ "n" }, "<leader>wK", "<C-W>K", { desc = "Move window up", remap = true })
km.set({ "n" }, "<leader>wL", "<C-W>L", { desc = "Move window right", remap = true })

-- Window spliting
km.set({ "n" }, "<leader>ws", "<C-W>s", { desc = "Split Window below", remap = true })
km.set({ "n" }, "<leader>wv", "<C-W>v", { desc = "Split Window right", remap = true })

-- Lazy
km.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
km.set("n", "<leader><C-L>", function() Util.news.changelog() end, { desc = "LazyVim Changelog" })
--
-- toggle options
km.set("n", "<leader>uD", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })


--
-- LazyVim Keybinds
--

-- better up/down
km.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
km.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
km.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
km.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
-- km.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
-- km.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- km.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
-- km.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
km.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
km.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
km.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
km.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
km.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
km.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
km.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
km.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
km.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
km.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
-- km.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- km.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
km.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
km.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
km.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
km.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
km.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
km.set( "n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
km.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
km.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
km.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
km.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
km.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
km.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
km.set("i", ",", ",<c-g>u")
km.set("i", ".", ".<c-g>u")
km.set("i", ";", ";<c-g>u")

-- save file
-- km.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
km.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
km.set("v", "<", "<gv")
km.set("v", ">", ">gv")

-- lazy
-- km.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
km.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

km.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
km.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

km.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
km.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- formatting
km.set({ "n", "v" }, "<leader>cf", function() Util.format({ force = true }) end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
km.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
km.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
km.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
km.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
km.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
km.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
km.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- toggle options
km.set("n", "<leader>uf", function() Util.format.toggle() end, { desc = "Toggle auto format (global)" })
km.set("n", "<leader>uF", function() Util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
km.set("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
km.set("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
km.set("n", "<leader>uL", function() Util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
km.set("n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
-- km.set("n", "<leader>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
km.set("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })

if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  km.set( "n", "<leader>uh", function() Util.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end

---@diagnostic disable-next-line: undefined-field
km.set("n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })
km.set("n", "<leader>ub", function() Util.toggle("background", false, {"light", "dark"}) end, { desc = "Toggle Background" })

-- lazygit
km.set("n", "<leader>gg", function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
km.set("n", "<leader>gG", function() Util.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

-- quit
-- km.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
km.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- LazyVim Changelog
-- km.set("n", "<leader>L", function() Util.news.changelog() end, { desc = "LazyVim Changelog" })

-- floating terminal
local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end
km.set("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
km.set("n", "<leader>fT", function() Util.terminal() end, { desc = "Terminal (cwd)" })
km.set("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
km.set("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal km.setpings
km.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
km.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
km.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
km.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
km.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
km.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
km.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
-- km.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
-- km.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
-- km.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
-- km.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
-- km.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
-- km.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
km.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
km.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
km.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
km.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
km.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
km.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
