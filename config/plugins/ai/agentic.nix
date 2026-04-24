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
      provider = "opencode-acp";
    };
    example = {
      enable = true;
      provider = "opencode-acp";
    };
    description = ''
      Enable agentic.nvim - Agentic Chat Interface for Neovim using ACP providers.
      Supported providers: claude-acp, opencode-acp, gemini-acp, codex-acp, cursor-acp, auggie-acp, mistral-vibe-acp
      Use different provider per tab - switch with <localLeader>s in chat widget.
    '';
  };

  config = lib.mkIf cfg.enable {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "agentic-nvim";
        version = "telescope";
        # NOTE: To update rev/hash: 1) Get new SHA from `gh api repos/antono/agentic.nvim/branches/telescope --jq '.commit.sha'`
        # 2) Use ANY placeholder hash (e.g., "sha256-0000000000000000000000000000000000000000000")
        # 3) Run `nix run .` to get the correct hash from the "got:" error message
        # 4) Update sha256 with the "got:" hash from the error
        # src = pkgs.fetchFromGitHub {
        #   owner = "antono";
        #   repo = "agentic.nvim";
        #   rev = "8b72beecdd22ad8756cec8ed6f32ead8857f4d9c";
        #   sha256 = "sha256-5NR2WrPjOUpAO3qAteGSVR8twUHlL429W5cPsHI0MfY=";
        # };
        src = pkgs.fetchFromGitHub {
          owner = "carlos-algms";
          repo = "agentic.nvim";
          rev = "HEAD";
          sha256 = "sha256-5bNpbupqRveqCgQ+jMSYIgqAQrqC7yOlt+avDsk95i4=";
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
      end, { desc = "Switch to next provider" })

      vim.api.nvim_create_user_command('AgenticStopGeneration', function()
        require("agentic").stop_generation()
      end, { desc = "Stop generation" })

      vim.api.nvim_create_user_command('AgenticRotateLayout', function()
        require("agentic").rotate_layout()
      end, { desc = "Rotate chat layout" })

      require("agentic").setup({
        provider = "${cfg.provider or "opencode-acp"}",
        diff_preview = {
          enabled = true,
          layout = "split",
          center_on_navigate_hunks = true,
        },
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<C-\\>";
        action = "<cmd>AgenticToggle<CR>";
        options.desc = "Toggle Agentic Chat";
      }
      {
        mode = "i";
        key = "<C-\\>";
        action = "<cmd>AgenticToggle<CR>";
        options.desc = "Toggle Agentic Chat";
      }
      {
        mode = "v";
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
        mode = "v";
        key = "<leader>as";
        action = "<cmd>AgenticAddSelection<CR>";
        options.desc = "Add selection to Agentic context";
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
        key = "<leader>ax";
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
