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
      renderer_options = {
        mermaid = {
          theme = "forest";
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
