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
        pname = "bruno-nvim";
        version = "81f0dea";
        src = pkgs.fetchFromGitHub {
          owner = "antono";
          repo = "bruno.nvim";
          rev = "81f0dea051de80f76a78c8aabb763e54edb2e1a0";
          hash = "sha256-HGFHJBwJ7tOATlr1oTPDoHWMYFPMP9q1CUEZfnSzmzM=";
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
