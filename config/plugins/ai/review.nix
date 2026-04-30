{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.plugins.review-nvim;
in
{
  options.plugins.review-nvim = lib.mkOption {
    type = lib.types.attrs;
    default = {
      enable = true;
    };
    example = {
      enable = true;
    };
    description = ''
      Enable review.nvim - Capture review comments directly from diffs in neovim.
      Features: line/block capture in diffs, floating comment editor, comment list,
      export to markdown or create Beads subtasks.
      Requires: Neovim 0.12+
    '';
  };

  config = lib.mkIf cfg.enable {
    extraPlugins = [
      # Dependency: codediff.nvim
      (pkgs.vimUtils.buildVimPlugin {
        pname = "codediff-nvim";
        version = "8afc229";
        src = pkgs.fetchFromGitHub {
          owner = "esmuellert";
          repo = "codediff.nvim";
          rev = "8afc229d38dc13ce71b2ffbb860084b2c726e061";
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
        doCheck = false;
      })
      # Main plugin: review.nvim
      (pkgs.vimUtils.buildVimPlugin {
        pname = "review-nvim";
        version = "10beb88";
        src = pkgs.fetchFromGitHub {
          owner = "slocook";
          repo = "review.nvim";
          rev = "10beb8811ad2d24062aef2cffac02b7d5feab039";
          sha256 = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
        };
        doCheck = false;
      })
    ];

    extraConfigLua = ''
      require("review").setup({
        export = {
          mode = "single",
          dir = vim.fn.stdpath("cache") .. "/review.nvim",
        },
        beads = {
          enabled = false,
          cmd = "bd",
          extra_args = {},
          parent_from_branch = true,
          branch_pattern = "epic/([^/]+)",
          prompt_if_missing = true,
        },
        ui = {
          border = "rounded",
          width = 0.7,
          height = 0.6,
          preview_height = 0.35,
          title = "Review Comment",
          float_border = "rounded",
          float_anchor = "left",
          auto_show_float = false,
        },
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>rc";
        action = "<cmd>ReviewComment<CR>";
        options.desc = "Add review comment";
      }
      {
        mode = "v";
        key = "<leader>rc";
        action = "<cmd>ReviewComment<CR>";
        options.desc = "Add review comment from selection";
      }
      {
        mode = "n";
        key = "<leader>rl";
        action = "<cmd>ReviewList<CR>";
        options.desc = "Open review comment list";
      }
      {
        mode = "n";
        key = "<leader>rs";
        action = "<cmd>ReviewShow<CR>";
        options.desc = "Show review comment at cursor";
      }
      {
        mode = "n";
        key = "<leader>re";
        action = "<cmd>ReviewExport<CR>";
        options.desc = "Export review comments";
      }
      {
        mode = "n";
        key = "<leader>rd";
        action = "<cmd>ReviewDelete<CR>";
        options.desc = "Delete review comment";
      }
    ];
  };
}
