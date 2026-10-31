{
  # A Neovim plugin for rendering diagrams, powered by image.nvim.
  # Formats: mermaid, plantuml, d2, gnuplot
  #
  # Disabled: the external renderers (mmdc, plantuml, d2, gnuplot) are not
  # bundled (mermaid-cli pulls in chromium and plantuml a JDK, ~1.8 GB), so
  # the plugin can't actually render anything as configured. On top of that,
  # image.nvim's kitty backend tries to write to the terminal during setup
  # and crashes `nix flake check`'s headless check (no TTY in the sandbox).
  # Re-enable both once renderers are installed locally and the backend is
  # verified to behave in headless mode.
  plugins.image.enable = false;
  plugins.diagram = {
    enable = false;
    settings = {
      integrations = [
        {
          __raw = "require('diagram.integrations.markdown')";
        }
      ];
      events = {
        # FIXME: Disable auto rendering
        render_buffer = [ ];
        clear_buffer = [ "BufLeave" ];
      };
      renderer_options = {
        mermaid = {
          background = "transparent";
          theme = "dark";
          scale = 3;
        };
        plantuml = {
          charset = "utf-8";
        };
      };
    };
  };
}
