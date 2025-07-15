{
  plugins.gitblame = {
    enable = true;
    autoLoad = true;
  };

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>gb";
      action = "<cmd>GitBlameToggle<cr>";
      options.desc = "Toggle Blame";
    }
  ];
}
