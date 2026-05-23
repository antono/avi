{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.plugins.agentic-nvim;
in
{
  options.plugins.agentic-nvim = lib.mkOption {
    type = lib.types.attrs;
    default = {
      enable = true;
      provider = "claude-acp";
    };
    example = {
      enable = true;
      provider = "claude-acp";
    };
    description = ''
      Enable agentic.nvim - Agentic Chat Interface for Neovim using ACP providers.
      Supported providers: claude-acp, opencode-acp, gemini-acp, codex-acp, cursor-acp, auggie-acp, mistral-vibe-acp
      Use different provider per tab - switch with <localLeader>s in chat widget.
    '';
  };

  config = lib.mkIf cfg.enable {
    plugins = {
      which-key.settings.spec = [
        {
          __unkeyed-1 = "<leader>a";
          group = "Agentic";
          icon = "󰯭";
        }
      ];
    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        # NOTE: To update rev/hash: 1) Get new SHA from `gh api repos/<owner>/<repo>/branches/<branch> --jq '.commit.sha'`
        # 2) Use ANY placeholder hash (e.g., "sha256-0000000000000000000000000000000000000000000")
        # 3) Run `nix run .` to get the correct hash from the "got:" error message
        # 4) Update sha256 with the "got:" hash from the error

        pname = "agentic-nvim";
        version = "57ec685";
        src = pkgs.fetchFromGitHub {
          owner = "carlos-algms";
          repo = "agentic.nvim";
          rev = "57ec685e434d41c31df4b263dfb16b5b43dcfa48";
          sha256 = "sha256-CBvvByPvB6ST3nlT/0ozhIPZ8HabwGaRlXn33BGIlF0=";
        };
        doCheck = false;
      })
    ];

    extraConfigLua = ''
      -- Commands for agentic.nvim
      vim.api.nvim_create_user_command('AgenticToggle', function()
        require("agentic").toggle()
      end, { desc = "Toggle Agentic Chat" })

      vim.api.nvim_create_user_command('AgenticNewSession', function()
        require("agentic").new_session()
      end, { desc = "New Agentic Session" })

      vim.api.nvim_create_user_command('AgenticAddSelection', function()
        require("agentic").add_selection_or_file_to_context()
      end, { desc = "Add selection to Agentic context" })

      vim.api.nvim_create_user_command('AgenticAddDiagnostics', function()
        require("agentic").add_current_line_diagnostics()
      end, { desc = "Add current line diagnostics to Agentic" })

      vim.api.nvim_create_user_command('AgenticAddAllDiagnostics', function()
        require("agentic").add_buffer_diagnostics()
      end, { desc = "Add all buffer diagnostics to Agentic" })

      vim.api.nvim_create_user_command('AgenticRestoreSession', function()
        require("agentic").restore_session()
      end, { desc = "Restore Agentic session" })

      vim.api.nvim_create_user_command('AgenticSwitchProvider', function()
        require("agentic").switch_provider()
      end, { desc = "Switch provider" })

      vim.api.nvim_create_user_command('AgenticStopGeneration', function()
        require("agentic").stop_generation()
      end, { desc = "Stop generation" })

      vim.api.nvim_create_user_command('AgenticRotateLayout', function()
        require("agentic").rotate_layout()
      end, { desc = "Rotate chat layout" })

      require("agentic").setup({
        provider = "${cfg.provider or "claude-acp"}",
        diff_preview = {
          enabled = true,
          layout = "split",
          center_on_navigate_hunks = true,
        },
      })
    '';

    keymaps = [
      {
        mode = [
          "n"
          "i"
          "v"
        ];
        key = "<C-\\>";
        action = "<cmd>AgenticToggle<CR>";
        options.desc = "Toggle Agentic Chat";
      }
      {
        mode = "n";
        key = "<leader>an";
        action = "<cmd>AgenticNewSession<CR>";
        options.desc = "New Agentic Session";
      }
      {
        mode = "n";
        key = "<leader>ar";
        action = "<cmd>AgenticRestoreSession<CR>";
        options.desc = "Restore Agentic Session";
      }
      {
        mode = [
          "v"
          "n"
        ];
        key = "<leader>as";
        action = "<cmd>AgenticAddSelection<CR>";
        options.desc = "Add selection/file to Agentic context";
      }
      {
        mode = "n";
        key = "<leader>ad";
        action = "<cmd>AgenticAddDiagnostics<CR>";
        options.desc = "Add current line diagnostics";
      }
      {
        mode = "n";
        key = "<leader>aD";
        action = "<cmd>AgenticAddAllDiagnostics<CR>";
        options.desc = "Add all buffer diagnostics";
      }
      {
        mode = "n";
        key = "<leader>ap";
        action = "<cmd>AgenticSwitchProvider<CR>";
        options.desc = "Switch provider";
      }
      {
        mode = "n";
        key = "<leader>aS";
        action = "<cmd>AgenticStopGeneration<CR>";
        options.desc = "Stop generation";
      }
      {
        mode = "n";
        key = "<leader>al";
        action = "<cmd>AgenticRotateLayout<CR>";
        options.desc = "Rotate layout";
      }
    ];
  };
}
