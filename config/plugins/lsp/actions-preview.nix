{
  plugins.actions-preview = {
    enable = true;
    settings = {
      telescope = {
        sorting_strategy = "ascending";
        layout_strategy = "vertical";
        layout_config = {
          width = 0.8;
          height = 0.9;
          prompt_position = "top";
          preview_cutoff = 20;
          preview_height = ''
            function(_, _, max_lines)
              return max_lines - 15
            end'';
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>ca";
      # FIXME:
      action = "<cmd>lua require('actions-preview').code_actions<cr>";
      options.desc = "Code actions";
    }
  ];
}
