-- VSCode-style git detection for git-backed commands.
-- In a repo: runs the command as-is.
-- Outside a repo: finds nearby repos and picks one, remembering the choice per-dir.
-- Mirrors the `lg` zsh function in ~/.config/zsh/lazygit-picker.zsh — same memo file.

local M = {}

local scan_depth = vim.g.lazygit_scan_depth or 4
local memo = vim.fn.expand("~/.local/state/repo-picker") -- TSV: cwd<TAB>repo

--- repo previously picked for `cwd`, if it still exists
local function recall(cwd)
  if vim.fn.filereadable(memo) == 0 then
    return nil
  end
  for _, line in ipairs(vim.fn.readfile(memo)) do
    local k, v = line:match("^(.-)\t(.*)$")
    if k == cwd and vim.fn.isdirectory(v) == 1 then
      return v
    end
  end
end

local function remember(cwd, repo)
  local out = { cwd .. "\t" .. repo }
  if vim.fn.filereadable(memo) == 1 then
    for _, line in ipairs(vim.fn.readfile(memo)) do
      if not vim.startswith(line, cwd .. "\t") then
        table.insert(out, line)
      end
    end
  end
  vim.fn.mkdir(vim.fn.fnamemodify(memo, ":h"), "p")
  vim.fn.writefile(out, memo)
end

--- repo root containing `dir`, or nil
local function git_root(dir)
  local out = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return out[1]
end

--- repos at or under `dir`, absolute, sorted
local function scan(dir)
  local cmd
  if vim.fn.executable("fd") == 1 then
    cmd = {
      "fd", "-H", "-u", "--max-depth", tostring(scan_depth),
      "-E", "node_modules", "-E", ".cache", "-E", ".venv",
      "-E", "vendor", "-E", "target",
      "^\\.git$", dir,
    }
  else
    cmd = {
      "find", dir, "-maxdepth", tostring(scan_depth), "-name", ".git",
      "-not", "-path", "*/node_modules/*",
    }
  end

  local hits = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    return {}
  end

  local seen, roots = {}, {}
  for _, hit in ipairs(hits) do
    local root = vim.fn.fnamemodify(hit:gsub("/$", ""), ":h")
    if not seen[root] then
      seen[root] = true
      table.insert(roots, root)
    end
  end
  table.sort(roots)
  return roots
end

--- lazygit's own recent-repos list, still-existing entries only
local function recents()
  local state = vim.fn.expand("~/.local/state/lazygit/state.yml")
  if vim.fn.filereadable(state) == 0 then
    return {}
  end

  local out, in_block = {}, false
  for _, line in ipairs(vim.fn.readfile(state)) do
    if line:match("^recentrepos:") then
      in_block = true
    elseif in_block then
      local path = line:match("^%s*%-%s*(.+)$")
      if path then
        if vim.fn.isdirectory(path) == 1 then
          table.insert(out, path)
        end
      else
        break -- next top-level key ends the list
      end
    end
  end
  return out
end

--- Resolve a repo, then hand it to `run(path)`.
--- `path` is nil when the cwd is already a repo, i.e. "just use the cwd".
--- `force` skips the remembered choice and re-opens the picker.
function M.with_repo(run, force)
  local cwd = vim.fn.getcwd()

  -- already in a repo: nothing to choose
  if git_root(cwd) then
    return run(nil)
  end

  -- picked here before? just reopen it
  if not force then
    local last = recall(cwd)
    if last then
      return run(last)
    end
  end

  local found = scan(cwd)

  -- exactly one repo below us: no point asking
  if #found == 1 then
    return run(found[1])
  end

  -- repos below us are what you meant; only fall back to lazygit's recent
  -- list (headed by an init entry) when there's nothing here at all.
  local init_entry = "+ git init here  (" .. cwd .. ")"
  local choices = found
  if #found == 0 then
    choices = { init_entry }
    vim.list_extend(choices, recents())
  end

  if #choices == 0 then
    vim.notify(
      ("no git repos found under %s (depth %d)"):format(cwd, scan_depth),
      vim.log.levels.WARN
    )
    return
  end

  vim.ui.select(choices, {
    prompt = "No repo in " .. vim.fn.fnamemodify(cwd, ":~") .. " — pick one:",
    format_item = function(item)
      if item == init_entry then
        return item
      end
      return vim.fn.fnamemodify(item, ":~")
    end,
  }, function(choice)
    if not choice then
      return
    end
    if choice == init_entry then
      vim.fn.system({ "git", "-C", cwd, "init" })
      if vim.v.shell_error ~= 0 then
        vim.notify("git init failed in " .. cwd, vim.log.levels.ERROR)
        return
      end
      return run(nil)
    end
    remember(cwd, choice)
    run(choice)
  end)
end

--- <leader>lg — lazygit, repo-picked when cwd isn't one
function M.lazygit(force)
  M.with_repo(function(path)
    require("lazygit").lazygit(path)
  end, force)
end

--- <leader>fa — fzf-lua git_status, repo-picked when cwd isn't one
function M.git_status(force)
  M.with_repo(function(path)
    require("fzf-lua").git_status(path and { cwd = path } or {})
  end, force)
end

return M
