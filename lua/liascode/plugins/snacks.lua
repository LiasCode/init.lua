---@type Array<LazyPluginSpec>
return {
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          explorer = {
          }
        }
      },
      ---@class snacks.explorer.Config
      explorer = {
        replace_netrw = true,
      },
      terminal = {}
    },

    lazy = false,
    priority = 1000,

    config = function()
      local Snacks = require("snacks");

      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()

      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params
              .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          Snacks.notifier.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
    keys = {
      -- Top Pickers & Explorer
      { "<leader>,",   function() Snacks.picker.buffers() end,              desc = "Buffers" },
      { "<leader>/",   function() Snacks.picker.grep() end,                 desc = "Grep" },
      { "<leader>:",   function() Snacks.picker.command_history() end,      desc = "Command History" },
      -- { "<leader>ef",  function() Snacks.explorer() end,                    desc = "File Explorer" },

      -- find
      { "<leader>fb",  function() Snacks.picker.buffers() end,              desc = "Buffers" },
      { "<leader-ff>", function() Snacks.picker.files() end,                desc = "Find Files" },
      { "<C-p>",       function() Snacks.picker.git_files() end,            desc = "Find Git Files" },

      -- git
      { "<leader>gb",  function() Snacks.picker.git_branches() end,         desc = "Git Branches" },
      { "<leader>gl",  function() Snacks.picker.git_log() end,              desc = "Git Log" },
      { "<leader>gs",  function() Snacks.picker.git_status() end,           desc = "Git Status" },

      -- Grep
      { "<leader>sb",  function() Snacks.picker.grep_buffers() end,         desc = "Grep Open Buffers" },
      { "<leader>sw",  function() Snacks.picker.grep_word() end,            desc = "Visual selection or word", mode = { "n", "x" } },

      -- search
      { "<leader>db",  function() Snacks.picker.diagnostics_buffer() end,   desc = "Diagnostics" },
      { "<leader>dd",  function() Snacks.picker.diagnostics() end,          desc = "Diagnostics" },
      { "<leader>si",  function() Snacks.picker.icons() end,                desc = "Icons" },
      { "<leader>cs",  function() Snacks.picker.colorschemes() end,         desc = "Colorschemes" },

      -- LSP
      { "gd",          function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
      { "gD",          function() Snacks.picker.lsp_declarations() end,     desc = "Goto Declaration" },
      { "gr",          function() Snacks.picker.lsp_references() end,       nowait = true,                     desc = "References" },
      { "gI",          function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
      { "gy",          function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    }
  }
}
