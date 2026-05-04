{
  plugins.codesnap = {
    enable = true;
    settings = {
      breadcrumbs_separator = "/";
      has_breadcrumbs = true;
      has_line_number = false;
      mac_window_bar = true;
      save_path = "~/Pictures/Codesnap/";
      title = "CodeSnap.nvim";
      watermark = "";
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>cs";
      action = "<cmd>CodeSnap<cr>";
      options.desc = "Screenshot";
    }
    {
      mode = "n";
      key = "<leader>cS";
      action = "<cmd>CodeSnapASCII<cr>";
      options.desc = "Asciishot";
    }
  ];
}
