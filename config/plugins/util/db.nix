{
  config,
  lib,
  pkgs,
  ...
}:
{
  plugins = {
    vim-dadbod.enable = true;
    vim-dadbod-ui.enable = true;
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
