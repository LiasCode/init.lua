---@type LazyPluginSpec
return {
    'saghen/blink.cmp',
    dependencies = {
        "rafamadriz/friendly-snippets",
        "mikavilpas/blink-ripgrep.nvim",
        "fang2hou/blink-copilot",
        "onsails/lspkind.nvim",
        "saghen/blink.compat",
        "neovim/nvim-lspconfig",
    },
    version = '1.*',
    config = function()
        require("blink.cmp").setup({
            cmdline = { enabled = true },
            fuzzy = {
                implementation = "prefer_rust_with_warning",
                sorts = {
                    "exact",
                    "score",
                    "sort_text"
                }
            },
            keymap = {
                ['<tab>'] = { 'select_and_accept', 'fallback' },
                ['<CR>'] = { 'select_and_accept', 'fallback' }
            },
            sources = {
                default = {
                    "lsp", "path", "snippets", "buffer"
                },
                providers = {
                    buffer = {
                        opts = {
                            get_bufnrs = function()
                                return vim.tbl_filter(function(bufnr)
                                    return vim.bo[bufnr].buftype == ''
                                end, vim.api.nvim_list_bufs())
                            end
                        }
                    }
                },
            },
            appearance = {
                kind_icons = {
                    Copilot = "",
                },
            },
            signature = { enabled = true },
            ---@type blink.cmp.CompletionMenuConfigPartial
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 30,
                    window = { border = "rounded" },
                },
                ghost_text = {
                    enabled = false,
                },
                trigger = {
                    prefetch_on_insert = false
                },
                list = {
                    selection = { preselect = true, auto_insert = true }
                },
                menu = {
                    border = "rounded",
                    draw = {
                        padding = { 1, 1 },
                        treesitter = { "lsp" },
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local icon = ctx.kind_icon
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    elseif ctx.source_name == "copilot" then
                                        icon = "😺"
                                    elseif ctx.source_name == "Ripgrep" then
                                        icon = "🔍"
                                    elseif ctx.source_name == "minuet" then
                                        icon = "💃🏻"
                                    else
                                        -- icon = require("lspkind").get_kind_icon(ctx.kind_icon)
                                    end
                                    return icon .. ctx.icon_gap
                                end,

                                -- Optionally, use the highlight groups from nvim-web-devicons
                                -- You can also add the same function for `kind.highlight` if you want to
                                -- keep the highlight groups in sync with the icons.
                                highlight = function(ctx)
                                    local hl = ctx.kind_hl
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end
                                    return hl
                                end,
                            },
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        }
                    }
                }
            }
        })
    end,
    opts_extend = { "sources.default" }
}
