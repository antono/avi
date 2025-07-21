{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.notmuch-vim
    (pkgs.vimUtils.buildVimPlugin {
      name = "notmuch";
      src = pkgs.fetchFromGitHub {
        owner = "yousefakbar";
        repo = "notmuch.nvim";
        rev = "e4b0a6cbbe5e5281f7a6a8fa43c3e776d3eaec64";
        hash = "sha256-/T8gGRJUCy4mtnl6/ItOLvJPUq39RVj2EGrKoJ+WvOA=";
      };
      nvimSkipModules = [
        "notmuch.cnotmuch"
      ];
    })
  ];

  extraPackages = [
    pkgs.notmuch
    pkgs.python3Packages.notmuch
  ];
}
