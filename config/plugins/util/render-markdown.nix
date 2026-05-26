{ lib, ... }:
{
  plugins.render-markdown = {
    enable = true;
    settings = {
      file_types = [
        "markdown"
        "md"
        "AgenticChat"
      ];
    };
  };

  # agentic.nvim streams content into the AgenticChat buffer via
  # nvim_buf_set_lines from a job callback. That API does not fire
  # TextChanged, and the cursor never moves in an unfocused window, so
  # render-markdown's buffer-scoped autocmds (TextChanged / CursorMoved /
  # WinScrolled) never trigger a re-render until the user focuses the
  # window and BufWinEnter fires. Hook nvim_buf_attach so we can refresh
  # on every line change, regardless of focus.
  extraConfigLua = ''
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("RenderMarkdownAgenticChat", { clear = true }),
      pattern = "AgenticChat",
      callback = function(args)
        local buf = args.buf
        if vim.b[buf].render_markdown_agentic_attached then
          return
        end
        vim.b[buf].render_markdown_agentic_attached = true

        local timer = nil
        vim.api.nvim_buf_attach(buf, false, {
          on_lines = function()
            if not vim.api.nvim_buf_is_valid(buf) then
              return true
            end
            if timer then
              timer:stop()
              timer:close()
            end
            timer = vim.uv.new_timer()
            timer:start(50, 0, vim.schedule_wrap(function()
              if timer then
                timer:close()
                timer = nil
              end
              if not vim.api.nvim_buf_is_valid(buf) then
                return
              end
              local ok, api = pcall(require, "render-markdown.api")
              if ok then
                pcall(api.render, { buf = buf })
              end
            end))
          end,
          on_detach = function()
            if timer then
              timer:stop()
              timer:close()
              timer = nil
            end
          end,
        })
      end,
    })
  '';
}
