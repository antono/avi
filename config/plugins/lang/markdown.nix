{
  lib,
  pkgs,
  ...
}:
{
  extraPackages = with pkgs; [
    marksman
    imagemagick
  ];

  plugins = {
    markdown-preview = {
      enable = true;
      autoLoad = true;
      # Use fork's `markdown-review` branch (pinned commit) instead of upstream.
      package = pkgs.vimPlugins.markdown-preview-nvim.overrideAttrs (_: {
        src = pkgs.fetchFromGitHub {
          owner = "antono";
          repo = "markdown-preview.nvim";
          rev = "683b6c4773c8f58d013d6df7739f709f3a6c22fa"; # branch: markdown-review
          hash = "sha256-o/cs2+roQMqhr+kdeNYsOWvXMR3DBokQE1Zuejmkh8Y=";
        };
      });
    };

    # conform-nvim.settings = {
    #   formatters_by_ft.markdown = [ "deno_fmt" ];
    #
    #   formatters = {
    #     deno_fmt.command = lib.getExe pkgs.deno;
    #   };
    # };

    lsp.servers = {
      marksman.enable = true;
    };

    lint = {
      lintersByFt.markdown = [ "markdownlint" ];
      linters.markdownlint.cmd = lib.getExe pkgs.markdownlint-cli;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>mp";
      action = "<cmd>MarkdownPreviewToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle markdown preview";
      };
    }
    {
      mode = "n";
      key = "<leader>mr";
      action = "<cmd>MarkdownReview<cr>";
      options = {
        silent = true;
        desc = "Toggle markdown Review";
      };
    }
  ];
}
