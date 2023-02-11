local default_opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

local status_ok, handler = pcall(require, "lazy.core.handler")

if not status_ok then
  require("base.leader")
end

local function map(mode, lhs, rhs, opts)
  if not status_ok then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  else
    local keys = handler.handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
      opts = opts or {}
      opts.silent = opts.silent ~= false
      vim.keymap.set(mode, lhs, rhs, opts)
    end
  end
end

map({ "!" }, "jk", [[<c-\><c-n>]], { desc = "Exit to normal mode" })

--map({ 'n' }, '<leader>,e', ':e <C-R>=expand("%:p:h") . "/" <CR>', { desc = "Edit current directory" })
--map({ 'n' }, '<leader>,r', ':r <C-R>=expand("%:p:h") . "/" <CR>', { desc = "Read current directory" })

-- Move lines in visual mode with J/K
map({ "v" }, "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map({ "v" }, "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Copy to system clipboard
map({ "v", "n" }, "<leader>y", '"+y', { desc = "copy to clipboard" })
map({ "n" }, "<leader>Y", '"+Y', { desc = "copy line to clipboard" })

-- Window navigation
map({ "n" }, "<leader>ww", "<cmd>wincmd w<CR>", { desc = "Focus window below/right if none top-left" })
map({ "n" }, "<leader>wh", "<cmd>wincmd h<CR>", { desc = "Focus window right of current" })
map({ "n" }, "<leader>wj", "<cmd>wincmd j<CR>", { desc = "Focus window below of current" })
map({ "n" }, "<leader>wk", "<cmd>wincmd k<CR>", { desc = "Focus window above of current" })
map({ "n" }, "<leader>wl", "<cmd>wincmd l<CR>", { desc = "Focus window left of current" })
map({ "n" }, "<leader>wt", "<cmd>wincmd t<CR>", { desc = "Focus top left window" })
map({ "n" }, "<leader>wb", "<cmd>wincmd b<CR>", { desc = "Focus bottom right window" })
map({ "n" }, "<leader>wp", "<cmd>wincmd p<CR>", { desc = "Focus previous (last accessed window)" })

-- Window movement
map({ "n" }, "<leader>wr", "<cmd>wincmd r<CR>", { desc = "Rotate windows downards/rightwards" })
map({ "n" }, "<leader>wR", "<cmd>wincmd R<CR>", { desc = "Rotate windows upwards/leftwards" })
map({ "n" }, "<leader>wx", "<cmd>wincmd x<CR>", { desc = "Exchange current window with next one" })
map({ "n" }, "<leader>wH", "<cmd>wincmd H<CR>", { desc = "Move current window to the far left" })
map({ "n" }, "<leader>wJ", "<cmd>wincmd J<CR>", { desc = "Move current window to the very bottom" })
map({ "n" }, "<leader>wK", "<cmd>wincmd K<CR>", { desc = "Move current window to the very top" })
map({ "n" }, "<leader>wL", "<cmd>wincmd L<CR>", { desc = "Move current window to the far right" })
map({ "n" }, "<leader>wT", "<cmd>wincmd T<CR>", { desc = "Move current window to a new tab page" })

-- Window resizing
-- TODO: Figure how how to use count in keybinds

-- Window spliting
map({ "n" }, "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split window in two." })
map({ "n" }, "<leader>ws", "<cmd>split<CR>", { desc = "Split window in two (vertically)." })

-- Buffer navigation
-- TODO: desc
map({ "n" }, "<leader>bl", "<cmd>e#<CR>", opts)
map({ "n" }, "<leader>bp", "<cmd>bprevious<CR>", opts)
map({ "n" }, "<leader>bn", "<cmd>bnext<CR>", opts)
map({ "n" }, "<leader>bd", "<cmd>bdelete<CR>", opts)
