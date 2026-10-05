{ pkgs, ... }:
{
  enableMan = false;
  # Import all your configuration modules here

  imports = [
    ./autocmd.nix
    ./keymaps.nix
    ({ pkgs, ... }: import ./settings.nix { inherit pkgs; })
    ./plugins
  ];

  extraPackages = with pkgs; [
    ripgrep
    lazygit
    fzf
    fd

    pyright
    ruff

    typos-lsp
  ];
}
