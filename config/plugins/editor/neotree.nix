{ icons, ... }:
{
  plugins.neo-tree = {
    enable = true;
    settings = {
      close_if_last_window = true;
      sources = [
        "filesystem"
        "buffers"
        "git_status"
        "document_symbols"
      ];
      popup_border_style = "rounded"; # “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
      filesystem = {
        bind_to_cwd = false;
        use_libuv_file_watcher = true;
        follow_current_file.enabled = true;
      };
      default_component_configs = {
        git_status = {
          symbols = {
            added = icons.git.LineAdded;
            conflict = icons.git.FileConflict;
            deleted = icons.git.FileDeleted;
            ignored = icons.git.FileIgnored;
            modified = icons.git.LineModified;
            renamed = icons.git.FileRenamed;
            staged = icons.git.FileStaged;
            unstaged = icons.git.FileUnstaged;
            untracked = icons.git.FileUntracked;
          };
        };
      };
    };

  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>E";
      action = "<cmd>Neotree toggle<cr>";
      options = {
        silent = true;
        desc = "Explorer NeoTree (root dir)";
      };
    }
  ];
}
