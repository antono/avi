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
      action = "<cmd>lua require('smart-splits').resize_right(15)<cr>";
      options.desc = "Increase window width";
    }

    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-h>";
      action = "<cmd>lua require('smart-splits').resize_left(15)<cr>";
      options.desc = "Decrease window width";
    }

    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-j>";
      action = "<cmd>lua require('smart-splits').resize_down(15)<cr>";
      options.desc = "Decrease window height";
    }

    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-k>";
      action = "<cmd>lua require('smart-splits').resize_up(15)<cr>";
      options.desc = "Increase window height";
    }

    # Windows - Resize small (with Shift, normal + terminal mode)
    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-S-l>";
      action = "<cmd>lua require('smart-splits').resize_right(7)<cr>";
      options.desc = "Increase window width (small)";
    }

    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-S-h>";
      action = "<cmd>lua require('smart-splits').resize_left(7)<cr>";
      options.desc = "Decrease window width (small)";
    }

    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-S-j>";
      action = "<cmd>lua require('smart-splits').resize_down(7)<cr>";
      options.desc = "Decrease window height (small)";
    }

    {
      mode = [
        "n"
        "t"
      ];
      key = "<C-A-S-k>";
      action = "<cmd>lua require('smart-splits').resize_up(7)<cr>";
      options.desc = "Increase window height (small)";
    }
  ];
}
