{
  lib,
  pkgs,
  ...
}:
{
  extraPackages = with pkgs; [
    marksman
    imagemagick
  ];

  plugins = {
    markdown-preview = {
      enable = true;
      autoLoad = true;
    };

    # conform-nvim.settings = {
    #   formatters_by_ft.markdown = [ "deno_fmt" ];
    #
    #   formatters = {
    #     deno_fmt.command = lib.getExe pkgs.deno;
    #   };
    # };

    lsp.servers = {
      marksman.enable = true;
    };

    lint = {
      lintersByFt.markdown = [ "markdownlint" ];
      linters.markdownlint.cmd = lib.getExe pkgs.markdownlint-cli;
    };
  };

  # keymaps = [
  #   {
  #     mode = "n";
  #     key = "<leader>m";
  #     action = "<cmd>MarkdownPreviewToggle<cr>";
  #     options = {
  #       silent = true;
  #       desc = "Toggle markdown preview";
  #     };
  #   }
  # ];
}
