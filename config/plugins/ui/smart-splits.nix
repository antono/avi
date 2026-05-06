{
  plugins.smart-splits.enable = true;

  keymaps = [
    # Windows - Resize
    {
      mode = "n";
      key = "<C-l>";
      action = "<cmd>lua require('smart-splits').resize_right(5)<cr>";
      options.desc = "Increase window width";
    }

    {
      mode = "n";
      key = "<C-h>";
      action = "<cmd>lua require('smart-splits').resize_left(5)<cr>";
      options.desc = "Decrease window width";
    }

    {
      mode = "n";
      key = "<C-j>";
      action = "<cmd>lua require('smart-splits').resize_down(2)<cr>";
      options.desc = "Decrease window height";
    }

    {
      mode = "n";
      key = "<C-k>";
      action = "<cmd>lua require('smart-splits').resize_up(2)<cr>";
      options.desc = "Increase window height";
    }
  ];
}
