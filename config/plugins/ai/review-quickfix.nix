{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.plugins.review-quickfix-nvim;
in
{
  options.plugins.review-quickfix-nvim = lib.mkOption {
    type = lib.types.attrs;
    default = {
      enable = true;
    };
    example = {
      enable = true;
    };
    description = """
      Enable quickfix-review.nvim - Turn review comments into quickfix entries.
      Features: integrate with review.nvim to show comments as quickfix list entries,
      jump between comments, and navigate review comments directly from the quickfix window.
      Requires: Neovim 0.12+ and review.nvim.
    """;
  };

  config = lib.mkIf cfg.enable {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "quickfix-review-nvim";
        version = "591492429572b3d81a9c4803cb10abfb6e69da46";
        src = pkgs.fetchFromGitHub {
          owner = "MMesch";
          repo = "quickfix-review-nvim";
          rev = "591492429572b3d81a9c4803cb10abfb6e69da46";
          # NOTE: To update rev/hash: 1) Get new SHA from `gh api repos/MMesch/quickfix-review-nvim/branches/main --jq '.commit.sha'`
          # 2) Use ANY placeholder hash (e.g., "sha256-0000000000000000000000000000000000000000000")
          # 3) Run `nix run .` to get the correct hash from the "got:" error message
          # 4) Update sha256 with the "got:" hash from the error
          sha256 = "sha256-3/lVLGNxURIf6dadCjnETk4nFbnwWgY5venepaC273k=";
        };
        doCheck = false;
      })
    ];

    extraConfigLua = ''
      require("quickfix-review").setup()
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>ri";
        action = "<cmd>ReviewAddIssue<CR>";
        options.desc = "Add ISSUE review comment";
      }
      {
        mode = "v";
        key = "<leader>ri";
        action = "<cmd>ReviewAddIssue<CR>";
        options.desc = "Add ISSUE review comment from selection";
      }
      {
        mode = "n";
        key = "<leader>rs";
        action = "<cmd>ReviewAddSuggestion<CR>";
        options.desc = "Add SUGGESTION review comment";
      }
      {
        mode = "v";
        key = "<leader>rs";
        action = "<cmd>ReviewAddSuggestion<CR>";
        options.desc = "Add SUGGESTION review comment from selection";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>ReviewAddNote<CR>";
        options.desc = "Add NOTE review comment";
      }
      {
        mode = "v";
        key = "<leader>rn";
        action = "<cmd>ReviewAddNote<CR>";
        options.desc = "Add NOTE review comment from selection";
      }
      {
        mode = "n";
        key = "<leader>rp";
        action = "<cmd>ReviewAddPraise<CR>";
        options.desc = "Add PRAISE review comment";
      }
      {
        mode = "v";
        key = "<leader>rp";
        action = "<cmd>ReviewAddPraise<CR>";
        options.desc = "Add PRAISE review comment from selection";
      }
      {
        mode = "n";
        key = "<leader>rd";
        action = "<cmd>ReviewDelete<CR>";
        options.desc = "Delete review comment at cursor";
      }
      {
        mode = "n";
        key = "<leader>rv";
        action = "<cmd>ReviewView<CR>";
        options.desc = "View review comment at cursor";
      }
      {
        mode = "n";
        key = "<leader>re";
        action = "<cmd>ReviewExport<CR>";
        options.desc = "Export review to markdown";
      }
      {
        mode = "n";
        key = "<leader>rc";
        action = "<cmd>ReviewClear<CR>";
        options.desc = "Clear all review comments";
      }
      {
        mode = "n";
        key = "<leader>rw";
        action = "<cmd>ReviewSave<CR>";
        options.desc = "Save review to disk";
      }
      {
        mode = "n";
        key = "<leader>rl";
        action = "<cmd>ReviewLoad<CR>";
        options.desc = "Load review from disk";
      }
      {
        mode = "n";
        key = "<leader>rS";
        action = "<cmd>ReviewSummary<CR>";
        options.desc = "Show review comment summary";
      }
      {
        mode = "n";
        key = "<leader>rg";
        action = "<cmd>ReviewGoto<CR>";
        options.desc = "Jump to real file from diff";
      }
    ];
  };
}
