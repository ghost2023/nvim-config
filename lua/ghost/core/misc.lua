local api = vim.api

local delay = 250 -- ms

local autosave = api.nvim_create_augroup("autosave", { clear = true })
api.nvim_create_user_command("AutoSave", function()
  local buf = api.nvim_get_current_buf()
  local enabled_ok, enabled = pcall(api.nvim_buf_get_var, buf, "auto_save_enabled")
  if not enabled_ok or enabled == false then
    vim.print("AutoSave enabled")
    api.nvim_buf_set_var(buf, "auto_save_enabled", true)
  end
  if enabled == true then
    vim.print("AutoSave disabled")
    api.nvim_buf_set_var(buf, "auto_save_enabled", false)
    return
  end
  api.nvim_buf_set_var(buf, "autosave_queued", false)
  api.nvim_buf_set_var(buf, "autosave_block", false)

  api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "TextChangedI" }, {
    pattern = "*",
    group = autosave,
    callback = function(ctx)
      if ctx.buf ~= buf then
        return
      end
      local this_enabled = api.nvim_buf_get_var(buf, "auto_save_enabled")

      if not this_enabled or not vim.bo.modified then
        return
      end

      local queued, queue_value = pcall(api.nvim_buf_get_var, buf, "autosave_queued")

      if not queued or not queue_value then
        vim.print("silent w")
        vim.cmd("silent w")
        api.nvim_buf_set_var(buf, "autosave_queued", true)
        vim.notify("Saved at " .. os.date("%H:%M:%S"))
      end

      local ok, block = pcall(api.nvim_buf_get_var, buf, "autosave_block")

      if not ok or not block then
        api.nvim_buf_set_var(buf, "autosave_block", true)
        vim.defer_fn(function()
          if api.nvim_buf_is_valid(buf) then
            api.nvim_buf_set_var(buf, "autosave_queued", false)
            api.nvim_buf_set_var(buf, "autosave_block", false)
          end
        end, delay)
      end
    end,
  })
end, {})
