{ pkgs, ... }:
{
  # A Neovim plugin for rendering diagrams, powered by image.nvim.
  # Formats: mermaid, plantuml, d2, gnuplot
  plugins.image.enable = true;
  plugins.diagram = {
    enable = true;
    settings = {
      integrations = [
        {
          __raw = "require('diagram.integrations.markdown')";
        }
      ];
      events = {
        render_buffer = [ ];
        clear_buffer = [ "BufLeave" ];
      };
      renderer_options = {
        mermaid = {
          background = "transparent";
          theme = "dark";
          scale = 2;
        };
        plantuml = {
          charset = "utf-8";
        };
      };
    };
  };

  extraPackages = with pkgs; [
    mermaid-cli
    plantuml
  ];
}
