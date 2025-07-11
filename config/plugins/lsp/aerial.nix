{ lib, config, ... }:
{
  plugins = {
    aerial = {
      enable = true;
      autoLoad = true;
      luaConfig.post = ''
        require("telescope").load_extension("aerial")
        require("telescope").setup({
          extensions = {
            aerial = {
              -- Set the width of the first two columns (the second
              -- is relevant only when show_columns is set to 'both')
              col1_width = 4,
              col2_width = 30,
              -- How to format the symbols
              format_symbol = function(symbol_path, filetype)
                if filetype == "json" or filetype == "yaml" then
                  return table.concat(symbol_path, ".")
                else
                  return symbol_path[#symbol_path]
                end
              end,
              -- Available modes: symbols, lines, both
              show_columns = "both",
            },
          },
        })
      '';
    };
  };

  keymaps = lib.mkIf config.plugins.aerial.enable [
    {
      mode = "n";
      key = "<leader>co";
      action = ''<cmd>AerialToggle<cr>'';
      options = {
        desc = "Code Outline";
      };
    }
    {
      mode = "v";
      key = "<leader>cc";
      action = ''<cmd>lua require('fastaction').range_code_action()<cr>'';
      options = {
        desc = "Fastaction code action";
      };
    }
    {
      mode = "n";
      key = "<leader>fR";
      action = "<cmd>Telescope aerial<cr>";
      options = {
        desc = "Symbol List";
        silent = true;
      };
    }
  ];
}
