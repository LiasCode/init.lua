---@brief
--- https://biomejs.dev
---
--- Toolchain of the web. [Successor of Rome](https://biomejs.dev/blog/annoucing-biome).
---
--- ```sh
--- npm install [-g] @biomejs/biome
--- ```
---
--- ### Monorepo support
---
--- `biome` supports monorepos by default. It will automatically find the `biome.json` corresponding to the package you are working on, as described in the [documentation](https://biomejs.dev/guides/big-projects/#monorepo). This works without the need of spawning multiple instances of `biome`, saving memory.

---@type vim.lsp.Config
return {
  -- Prefer local biome if present under root_dir; else fallback to global
  cmd = function(dispatchers, config)
    local exe = "biome"
    local root = config and config.root_dir
    if root then
      local local_bin = root .. "/node_modules/.bin/biome"
      if vim.fn.executable(local_bin) == 1 then
        exe = local_bin
      end
    end
    return vim.lsp.rpc.start({ exe, "lsp-proxy" }, dispatchers)
  end,

  filetypes = {
    "astro", "css", "graphql", "html",
    "javascript", "javascriptreact", "json", "jsonc",
    "svelte", "typescript", "typescriptreact", "vue",
  },

  workspace_required = true,

  -- Works with both sync and async call patterns
  root_dir = function(arg1, on_dir)
    -- Normalize arg
    local fname = type(arg1) == "number" and vim.api.nvim_buf_get_name(arg1) or arg1
    if fname == "" then
      if on_dir then return on_dir(vim.fn.getcwd()) end
      return vim.fn.getcwd()
    end

    local function up(names, stop)
      local found = vim.fs.find(names, { upward = true, path = fname, stop = stop })[1]
      return found and vim.fs.dirname(found) or nil
    end

    -- 1) Project root markers (flattened)
    local project_root = up({ "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", ".git" })
        or vim.fs.dirname(fname)

    -- 2) Decide if this buffer actually uses Biome
    local function has_biome_config()
      local cfg = vim.fs.find({ "biome.json", "biome.jsonc" }, {
        upward = true, path = fname, stop = project_root, type = "file", limit = 1,
      })[1]
      if cfg then return true end

      local pkg = vim.fs.find("package.json", { upward = true, path = fname, stop = project_root })[1]
      if not pkg then return false end

      local ok, json = pcall(vim.json.decode, table.concat(vim.fn.readfile(pkg), "\n"))
      if not ok or type(json) ~= "table" then return false end
      local deps = {}
      for k, v in pairs(json.dependencies or {}) do deps[k] = v end
      for k, v in pairs(json.devDependencies or {}) do deps[k] = v end
      -- Biome’s package is "@biomejs/biome"
      return deps["@biomejs/biome"] ~= nil
    end

    if not has_biome_config() then
      -- Don’t start the client if repo/package doesn’t use Biome
      if on_dir then return on_dir(nil) end
      return nil
    end

    if on_dir then return on_dir(project_root) end
    return project_root
  end,
}
