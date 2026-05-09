{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.plugins.bruno-nvim;
in
{
  options.plugins.bruno-nvim = lib.mkOption {
    type = lib.types.attrs;
    default = {
      enable = true;
      collectionPaths = [ ];
      picker = "telescope";
      showFormattedOutput = true;
      suppressFormattingErrors = false;
    };
    example = {
      enable = true;
      collectionPaths = [ ];
      picker = "telescope";
      showFormattedOutput = true;
      suppressFormattingErrors = false;
    };
    description = ''
      Enable bruno.nvim - Bruno API client integration for Neovim.
      Supports telescope, fzf-lua, and snacks pickers.
    '';
  };

  config = lib.mkIf cfg.enable {
    plugins.which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>B";
        group = "Bruno";
        icon = "󱏒";
      }
    ];

    keymaps = [
      {
        mode = [ "n" ];
        key = "<leader>Br";
        action = "<cmd>BrunoRun<cr>";
        options.desc = "Bruno Run";
      }
      {
        mode = [ "n" ];
        key = "<leader>Be";
        action = "<cmd>BrunoEnv<cr>";
        options.desc = "Bruno Select Env";
      }
      {
        mode = [ "n" ];
        key = "<leader>Bs";
        action = "<cmd>BrunoSearch<cr>";
        options.desc = "Bruno Search";
      }
      {
        mode = [ "n" ];
        key = "<leader>Bf";
        action = "<cmd>BrunoToggleFormat<cr>";
        options.desc = "Bruno Toggle Format";
      }
    ];

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        # NOTE: To update rev/hash:
        # 1) Get new rev SHA from github repo
        # 2) Use ANY placeholder hash (e.g., "sha256-0000000000000000000000000000000000000000000")
        # 3) Run `nix run .` to get the correct hash from the "got:" error message
        # 4) Update sha256 with the "got:" hash from the error
        pname = "bruno-nvim";
        version = "54bdebc";
        src = pkgs.fetchFromGitHub {
          owner = "romek-codes";
          repo = "bruno.nvim";
          rev = "54bdebc62aa6ffc7906464a20d182c0a660be836";
          hash = "sha256-YTNr0L7xuErETj+wDT7dFkjt+SPlFI3jr4ohfKuUPDU=";
        };
        doCheck = false;
      })
    ];

    extraConfigLua = ''
      require("bruno").setup({
        collection_paths = { ${lib.concatStringsSep ", " (map (p: "\"${p}\"") cfg.collectionPaths)} },
        picker = "${cfg.picker}",
        show_formatted_output = ${if cfg.showFormattedOutput then "true" else "false"},
        suppress_formatting_errors = ${if cfg.suppressFormattingErrors then "true" else "false"},
      })
    '';
  };
}
