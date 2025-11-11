{ config, lib, ... }:
{
  plugins.codecompanion = {
    enable = true;
  };

  keymaps = lib.optionals config.plugins.codecompanion.enable [
    {
      mode = "n";
      key = "<leader>ac";
      action = "<CMD>CodeCompanionChat Toggle<CR>";
      options.desc = "Code Companion";
    }
    {
      mode = "n";
      key = "<leader>aa";
      action = "<CMD>CodeCompanionActions<CR>";
      options.desc = "Open CodeCompanion Action Palette";
    }
    {
      mode = "n";
      key = "<leader>ae";
      action = "<CMD>CodeCompanion /explain<CR>";
      options.desc = "CodeCompanion Explain Prompt";
    }
    {
      mode = "n";
      key = "<leader>af";
      action = "<CMD>CodeCompanion /fix<CR>";
      options.desc = "CodeCompanion Fix Code Prompt";
    }
    {
      mode = "n";
      key = "<leader>am";
      action = "gM";
      options.desc = "CodeCompanion Clear Memory (chat buffer)";
    }
    {
      mode = "v";
      key = "<leader>at";
      action = ":CodeCompanion /tests<CR>";
      options = {
        desc = "Generate unit tests from selection";
        noremap = true;
        silent = true;
      };
    }
  ];
}
