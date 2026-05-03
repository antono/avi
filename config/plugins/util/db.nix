{
  config,
  lib,
  pkgs,
  ...
}:
{
  plugins = {
    vim-dadbod.enable = false;
    vim-dadbod-ui.enable = false;
  };

  keymaps = lib.mkIf config.plugins.vim-dadbod-ui.enable [
    {
      mode = "n";
      key = "<leader>D";
      action = "<cmd>DBUIToggle<CR>";
      options = {
        desc = "DBUI";
      };
    }
  ];

  extraPackages = lib.mkIf config.plugins.vim-dadbod-ui.enable [
    pkgs.postgresql
  ];
}
