{
  config,
  lib,
  pkgs,
  ...
}:
{
  extraPlugins = lib.mkIf config.plugins.avante.enable [
    pkgs.vimPlugins.img-clip-nvim
  ];

  plugins = {
    avante = {
      enable = false;
      settings = {
        mappings = {
          files = {
            add_current = "<leader>a.";
          };
        };
        provider = "copilot";
        poviders = {
          claude = {
            endpoint = "https://api.anthropic.com";
            extra_request_body = {
              max_tokens = 4096;
              temperature = 0;
            };
            model = "claude-3-5-sonnet-20240620";
          };
        };
      };
    };

    which-key.settings.spec = lib.optionals config.plugins.avante.enable [
      {
        __unkeyed-1 = "<leader>a";
        group = "Avante";
        icon = "";
      }
    ];
  };

  keymaps = lib.optionals config.plugins.avante.enable [
    {
      mode = "n";
      key = "<leader>ac";
      action = "<CMD>AvanteClear<CR>";
      options.desc = "avante: clear";
    }
  ];
}
