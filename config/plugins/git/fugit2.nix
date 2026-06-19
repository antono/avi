{
  # Configuration for fugit2 (https://nix-community.github.io/nixvim/plugins/fugit2/settings.html)
  plugins.fugit2 = {
    enable = false;

    # Options passed to require('fugit2').setup
    settings = {
      # Use the external diffview.nvim integration when available
      external_diffview = true;

      # Main popup dimensions (string percentages or integers)
      height = "90%"; # example from upstream docs
      width = "62%"; # example from upstream docs

      # When showing the file blame popup
      blame_info_height = 10;
      blame_info_width = 60;
      blame_priority = 1;

      # File view content width and min/max sizing when expanding patches
      content_width = 60;
      min_width = 50;
      max_width = "80%";

      # Whether to show the patch for the active file when opening fugit2
      show_patch = true;

      # Paths (leave null to use plugin defaults / environment)
      gpgme_path = "gpgme";
      libgit2_path = null;

      # Allow overriding the colorscheme used by fugit2 (null = plugin default)
      colorscheme = null;
    };
  };
}
