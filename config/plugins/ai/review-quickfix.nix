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
        version = "1.0.0";
        src = pkgs.fetchFromGitHub {
          owner = "MMesch";
          repo = "quickfix-review-nvim";
          rev = "1.0.0";
          # NOTE: To update rev/hash: 1) Get new SHA from `gh api repos/MMesch/quickfix-review-nvim/branches/main --jq '.commit.sha'`
          # 2) Use ANY placeholder hash (e.g., "sha256-0000000000000000000000000000000000000000000")
          # 3) Run `nix run .` to get the correct hash from the "got:" error message
          # 4) Update sha256 with the "got:" hash from the error
          sha256 = "sha256-0000000000000000000000000000000000000000000=";
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
        key = "<leader>rq";
        action = "<cmd>QuickfixReview<CR>";
        options.desc = "Show quickfix of review comments";
      }
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
