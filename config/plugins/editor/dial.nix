{
  plugins.dial = {
    enable = true;
  };

  # 17
  keymaps = [
    {
      mode = "n";
      key = "<C-a>";
      action = "<cmd>lua require('dial.map').manipulate('increment', 'normal')<cr>";
      options = {
        silent = true;
        desc = "Increment value";
      };
    }
    {
      mode = "n";
      key = "<C-x>";
      action = "<cmd>lua require('dial.map').manipulate('decrement', 'normal')<cr>";
      options = {
        silent = true;
        desc = "Decrement value";
      };
    }
  ];
}
