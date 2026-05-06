{
  plugins.smart-splits.enable = true;

  keymaps = [
    # Windows - Resize (normal + terminal mode)
    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-l>";
      action = "<cmd>lua require('smart-splits').resize_right(5)<cr>";
      options.desc = "Increase window width";
    }

    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-h>";
      action = "<cmd>lua require('smart-splits').resize_left(5)<cr>";
      options.desc = "Decrease window width";
    }

    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-j>";
      action = "<cmd>lua require('smart-splits').resize_down(2)<cr>";
      options.desc = "Decrease window height";
    }

    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-k>";
      action = "<cmd>lua require('smart-splits').resize_up(2)<cr>";
      options.desc = "Increase window height";
    }
  ];
}
