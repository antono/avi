{
  plugins.gitportal = {
    enable = true;
    settings = {
      always_include_current_line = true;
      default_remote = "origin";
      switch_branch_or_commit_upon_ingestion = "ask_first";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>go";
      action = "<cmd>GitPortal browse_file<CR>";
      options.desc = "Open file in browser";
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = "<cmd>GitPortal open_link<CR>";
      options.desc = "Open file via github/link";
    }
    {
      mode = "n";
      key = "<leader>gy";
      action = "<cmd>GitPortal copy_link_to_clipboard<CR>";
      options.desc = "Open file via github/link";
    }
  ];

}
