{
  plugins.twilight.enable = true;
  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>uT";
      action = "<cmd>Twilight<cr>";
      options.desc = "Toggle diming of inactive code";
    }
  ];
}
