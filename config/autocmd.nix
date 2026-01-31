{
  autoGroups = {
    # highlight_yank = { };
    vim_enter = { };
    indentscope = { };
    toggleterm_mappings = { };
    # restore_cursor = { };
  };

  autoCmd = [
    # highlight Text on Yank
    # {
    #   group = "highlight_yank";
    #   event = "TextYankPost";
    #   pattern = "*";
    #   callback = {
    #     __raw = "
    #     function()
    #       vim.highlight.on_yank()
    #     end
    #   ";
    #   };
    # }
    {
      group = "indentscope";
      event = [ "FileType" ];
      pattern = [
        "help"
        "Startup"
        "startup"
        "neo-tree"
        "Trouble"
        "trouble"
        "notify"
      ];
      callback = {
        __raw = ''
          function()
            vim.b.miniindentscope_disable = true
          end
        '';
      };
    }
    {
      group = "toggleterm_mappings";
      event = "TermEnter";
      pattern = "term://*toggleterm#*";
      callback = {
        __raw = ''
          function()
            vim.keymap.set('t', '<C-g>', function()
              vim.cmd(vim.v.count1 .. "ToggleTerm")
            end, { buffer = 0 })
          end
        '';
      };
    }
    ## from NVChad https://nvchad.com/docs/recipes (this autocmd will restore the cursor position when opening a file)
    # {
    #   group = "restore_cursor";
    #   event = [ "BufReadPost" ];
    #   pattern = "*";
    #   callback = {
    #     __raw = ''
    #       function()
    #         if
    #           vim.fn.line "'\"" > 1
    #           and vim.fn.line "'\"" <= vim.fn.line "$"
    #           and vim.bo.filetype ~= "commit"
    #           and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    #         then
    #           vim.cmd "normal! g`\""
    #         end
    #       end
    #     '';
    #   };
    # }
  ];
}
