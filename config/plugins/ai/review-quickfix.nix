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
    description = ''
      Enable quickfix-review.nvim - Turn review comments into quickfix entries.
      Features: integrate with review.nvim to show comments as quickfix list entries,
      jump between comments, and navigate review comments directly from the quickfix window.
      Requires: Neovim 0.12+ and review.nvim.
    '';
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
      require("quickfix-review").setup({
        keymaps = {
          add_comment_cycle = '<leader>ra',  -- Add comment with current cycle type
          cycle_next = '+',                  -- Cycle to next type
          cycle_previous = '-',              -- Cycle to previous type

          delete_comment = '<leader>rd',
          view = '<leader>rv',
          export = '<leader>ry',
          clear = '<leader>rc',
          summary = '<leader>rS',
          save = '<leader>rw',
          load = '<leader>rl',
          open_list = '<leader>ro',
          next_comment = ']r',
          prev_comment = '[r',
          goto_real_file = '<leader>cg',
        },
        -- Export filename (nil = clipboard only)
        export_file = nil,
        comment_types = {
          bug = { sign = '🐛', highlight = 'DiagnosticError', description = 'Bug' },
          idea = { sign = '💡', highlight = 'DiagnosticInfo', description = 'Idea' },
          security = { sign = '🔒', highlight = 'DiagnosticError', description = 'Security concern' },
          perf = { sign = '⚡', highlight = 'DiagnosticWarn', description = 'Performance issue' },
        },
        keymaps = {
          add_bug = '<leader>rb',
          add_idea = '<leader>ri',
          add_security = '<leader>rs',
          add_perf = '<leader>rp',
        },
      })
      vim.opt.signcolumn = "yes:2"  -- Reserve 2 columns for signs
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>ri";
        action = "<cmd>ReviewAddIssue<CR>";
        options.desc = "Add ISSUE review comment";
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
        key = "<leader>ry";
        action = "<cmd>ReviewExport<CR>";
        options.desc = "Yank review to clipboard";
      }
      {
        mode = "n";
        key = "<leader>rc";
        action = "<cmd>ReviewClear<CR>";
        options.desc = "Clear all review comments";
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
