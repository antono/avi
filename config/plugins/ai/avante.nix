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
        input = {
          provider = "native";
        };
        mappings = {
          files = {
            add_current = "<leader>a.";
          };
        };
        # provider = "copilot";
        provider = "gemini-cli";
        providers = {
          claude = {
            endpoint = "https://api.anthropic.com";
            extra_request_body = {
              max_tokens = 4096;
              temperature = 0;
            };
            model = "claude-3-5-sonnet-20240620";
          };
        };
        mode = "agentic";
        windows = {
          wrap = false;
        };
      };
    };
  };
}
