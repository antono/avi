{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    notmuch-vim
  ];
}
