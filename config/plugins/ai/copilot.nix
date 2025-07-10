{ config, lib, ... }:
{
  plugins = {
    copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = !config.plugins.blink-cmp-copilot.enable;
        suggestion.enabled = !config.plugins.blink-cmp-copilot.enable;
      };
    };

    copilot-chat = {
      inherit (config.plugins.copilot-lua) enable;
    };

    which-key.settings.spec = [
      {
        __unkeyed-1 = "<leader>A";
        mode = "n";
        icon = "";
        group = "+ai";
      }
    ];
  };

  keymaps = lib.mkIf config.plugins.copilot-chat.enable [
    {
      mode = "n";
      key = "<leader>Ac";
      action = "<cmd>CopilotChatToggle<CR>";
      options.desc = "Toggle Coilot Chat Window";
    }
    {
      mode = "n";
      key = "<leader>Aq";
      action.__raw = ''
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end
      '';
      options.desc = "Quick Chat";
    }
    {
      mode = "n";
      key = "<leader>Ah";
      action.__raw = ''
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end
      '';
      options.desc = "Help Actions";
    }
    {
      mode = "n";
      key = "<leader>Ap";
      action.__raw = ''
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end
      '';
      options.desc = "Prompt Actions";
    }
    {
      mode = "n";
      key = "<leader>Aa";
      action = "<cmd>CopilotChatAgents<CR>";
      options.desc = "List Available Agents";
    }
    {
      mode = "n";
      key = "<leader>Al";
      action = "<cmd>CopilotChatLoad<CR>";
      options.desc = "Load Chat History";
    }
    {
      mode = "n";
      key = "<leader>Am";
      action = "<cmd>CopilotChatModels<CR>";
      options.desc = "List Available Models";
    }
  ];
}
