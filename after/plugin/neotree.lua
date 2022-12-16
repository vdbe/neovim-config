require("neo-tree").setup({
    default_component_configs = {
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        modified = {
            symbol = "*",
            highlight = "NeoTreeModified",
        },
        indent = {
            padding = 0,
            with_expanders = false
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "",
        },
        git_status = {
            symbols = {
                -- Change type
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                deleted   = "✖", -- this can only be used in the git_status source
                renamed   = "", -- this can only be used in the git_status source
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
            }
        }
    },
    window = {
        position = "right",
        width = 25,
    },
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_by_name = {
                "node_modules",
                ".DS_Store",
                "thumbs.db",
                "__pycache"
            },
        },
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
    },
    event_handlers = {
        { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
    },
})
