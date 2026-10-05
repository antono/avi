{ pkgs, ... }:
{
  plugins.kulala.enable = true;

  # kulala shells out to jq (JSON) and xmllint (XML) for formatting responses
  extraPackages = with pkgs; [
    jq
    libxml2
  ];
}
