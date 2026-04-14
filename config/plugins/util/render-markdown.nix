{ lib, ... }:
{
  plugins.render-markdown = {
    enable = true;
    settings = {
      fileTypes = [
        "markdown"
        "md"
        "AgenticChat"
      ];
    };
  };
}
