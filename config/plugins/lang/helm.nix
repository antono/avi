{
  pkgs,
  lib,
  config,
  ...
}:
{
  plugins = {
    helm.enable = true;
  };

  autoCmd = lib.mkIf (config.plugins.helm.enable) [
    {
      event = "FileType";
      pattern = "helm";
      command = "LspRestart";
    }
  ];
}
