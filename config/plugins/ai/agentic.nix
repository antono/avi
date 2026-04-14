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

  config = lib.mkIf (cfg.enable or false) {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "agentic-nvim";
        version = "58c38cf";
        src = pkgs.fetchFromGitHub {
          owner = "carlos-algms";
          repo = "agentic.nvim";
          rev = "58c38cf5a8e77b3a88853e6f99cefdd5bcfbbe08";
          sha256 = "sha256-0hnrhjpjrdvsOZ9SegWFwnBy5RP1w/GKKcY2cRUVM/s=";
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

      require("agentic").setup({
        provider = "${cfg.provider or "opencode-acp"}",
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
    ];
  };
}
