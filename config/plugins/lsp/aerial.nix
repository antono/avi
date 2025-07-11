{ lib, config, ... }:
{
  plugins = {
    aerial = {
      enable = true;
      autoLoad = true;
    };
  };

  keymaps = lib.mkIf config.plugins.aerial.enable [
    {
      mode = "n";
      key = "<leader>co";
      action = ''<cmd>AerialToggle<cr>'';
      options = {
        desc = "Code Outline";
      };
    }
    {
      mode = "v";
      key = "<leader>cc";
      action = ''<cmd>lua require('fastaction').range_code_action()<cr>'';
      options = {
        desc = "Fastaction code action";
      };
    }
  ];
}
