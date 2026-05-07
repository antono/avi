{
  config,
  lib,
  pkgs,
  ...
}:
{
  extraPackages = [ pkgs.wl-clipboard ];
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

    local static = require("codesnap.static")
    local flat = static.config
    local sc = static.config.snapshot_config

    if flat.watermark then
      for k, v in pairs(flat.watermark) do
        sc.watermark[k] = v
      end
    end
    if flat.has_line_number ~= nil then
      static.config.show_line_number = flat.has_line_number
    end
    if flat.mac_window_bar ~= nil then
      sc.window.mac_window_bar = flat.mac_window_bar
    end
    if flat.has_breadcrumbs ~= nil then
      sc.code_config.breadcrumbs.enable = flat.has_breadcrumbs
    end
    if flat.breadcrumbs_separator then
      sc.code_config.breadcrumbs.separator = flat.breadcrumbs_separator
    end
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
          vim.cmd("delmarks <>")
          vim.notify("The snapshot is copied into clipboard successfully!")
        else
          vim.notify("Failed to save snapshot: " .. tostring(err), vim.log.levels.ERROR)
        end
        os.remove(tmp)
      end

      function codesnap.copy_ascii()
        local lines = vim.fn.getline("'<", "'>")
        local text = table.concat(lines, "\n")
        if text ~= "" then
          vim.fn.system({ clip_cmd }, text)
          vim.cmd("delmarks <>")
          vim.notify("The ASCII snapshot is copied into clipboard successfully!")
        else
          vim.notify("No code is selected", vim.log.levels.ERROR)
        end
      end

      vim.api.nvim_create_user_command("CodeSnap", function()
        codesnap.copy()
      end, { range = true })
      vim.api.nvim_create_user_command("CodeSnapASCII", function()
        codesnap.copy_ascii()
      end, { range = true })
    end
  '';

  keymaps = [
    {
      mode = [
        "v"
      ];
      key = "<leader>cs";
      action = "<Esc><cmd>CodeSnap<cr>";
      options.desc = "Screenshot";
    }
  ];
}
