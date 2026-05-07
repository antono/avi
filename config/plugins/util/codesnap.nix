{
  config,
  lib,
  ...
}:
{
  plugins.codesnap = {
    enable = true;
    settings = {
      breadcrumbs_separator = "/";
      has_breadcrumbs = true;
      has_line_number = true;
      mac_window_bar = false;
      save_path = "~/Pictures/Codesnap/";
      title = "CodeSnap";
      watermark = {
        content = "";
      };
    };
  };

  extraConfigLua = lib.mkIf config.plugins.codesnap.enable ''
    local codesnap = require("codesnap")
    local config_module = require("codesnap.config")
    local generator = require("generator")

    local clip_cmd
    if vim.fn.executable("wl-copy") == 1 then
      clip_cmd = "wl-copy"
    elseif vim.fn.executable("xclip") == 1 then
      clip_cmd = "xclip -selection clipboard"
    end

    if clip_cmd then
      function codesnap.copy()
        local tmp = os.tmpname() .. ".png"
        local ok, err = pcall(generator.save, tmp, config_module.get_config())
        if ok then
          vim.fn.system(clip_cmd == "wl-copy"
            and "wl-copy --type image/png < " .. vim.fn.shellescape(tmp)
            or "xclip -selection clipboard -t image/png < " .. vim.fn.shellescape(tmp))
        end
        os.remove(tmp)
        vim.cmd("delmarks <>")
        vim.notify("The snapshot is copied into clipboard successfully!")
      end

      function codesnap.copy_ascii()
        local lines = vim.fn.getline("'<", "'>")
        local text = table.concat(lines, "\n")
        if text ~= "" then
          vim.fn.system({ clip_cmd }, text)
        end
        vim.cmd("delmarks <>")
        vim.notify("The ASCII snapshot is copied into clipboard successfully!")
      end
    end
  '';

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cs";
      action = "<cmd>CodeSnap<cr>";
      options.desc = "Screenshot";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cS";
      action = "<cmd>CodeSnapASCII<cr>";
      options.desc = "Asciishot";
    }
  ];
}
