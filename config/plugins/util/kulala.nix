{ pkgs, ... }:
let

  kulala = pkgs.vimUtils.buildVimPlugin {
    pname = "kulala-nvim";
    version = "7649576";
    src = pkgs.fetchFromGitHub {
      owner = "mistweaverco";
      repo = "kulala.nvim";
      rev = "7649576ca459146658b4c415d1a320bbedc3f564";
      hash = "sha256-lsct1/VGj0rtX3xzoSKQD7Rji7zsNrWSsHyZr1fdU44=";
    };
    dependencies = with pkgs; [
      libxml2
      jq
    ];
  };

in
{
  extraPlugins = [ kulala ];

  extraConfigLua = ''
    require("kulala").setup({})
  '';
}
