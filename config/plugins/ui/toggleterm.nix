{ config, lib, ... }:
{
  plugins.toggleterm = {
    enable = true;
    settings = {
      size = ''
        function(term)
          if term.direction == "horizontal" then
            return 30
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end
      '';
      open_mapping = "[[<leader>fT]]";
      hide_numbers = true;
      shade_terminals = true;
      start_in_insert = true;
      terminal_mappings = true;
      persist_mode = false;
      insert_mappings = true;
      close_on_exit = true;
      shell = "~/.nix-profile/bin/bash";
      direction = "horizontal"; # 'vertical' | 'horizontal' | 'tab' | 'float'
      float_opts = {
        border = "single"; # 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        width = 80;
        height = 20;
        winblend = 0;
      };
    };
  };

  keymaps = lib.mkIf config.plugins.toggleterm.enable [
    {
      mode = [
        "t"
        "n"
      ];
      key = "<C-g>";
      action.__raw = ''
        function()
          vim.cmd(vim.v.count1 .. "ToggleTerm")
        end
      '';
      options.desc = "Open/Close Terminal with count";
    }
    {
      mode = "i";
      key = "<C-g>";
      action.__raw = ''
        function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
          vim.cmd(vim.v.count1 .. "ToggleTerm")
        end
      '';
      options.desc = "Open/Close Terminal with count";
    }
    {
      mode = [
        "t"
        "n"
      ];
      key = "<C-Left>";
      action = "<cmd>wincmd h<cr>";
      options.desc = "Go to Left window";
    }
    {
      mode = [
        "t"
        "n"
      ];
      key = "<C-Right>";
      action = "<cmd>wincmd l<cr>";
      options.desc = "Go to Right window";
    }
    {
      mode = [
        "t"
        "n"
      ];
      key = "<C-Up>";
      action = "<cmd>wincmd k<cr>";
      options.desc = "Go to Up window";
    }
    {
      mode = [
        "t"
        "n"
      ];
      key = "<C-Down>";
      action = "<cmd>wincmd j<cr>";
      options.desc = "Go to Down window";
    }
  ];
}
