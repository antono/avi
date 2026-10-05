{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs =
    { flake-parts, self, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              inherit inputs self;
            }
            // import ./lib { inherit pkgs; };
          };
          nvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule nixvimModule;
        in
        {
          # Run `nix flake check` to verify that your config is not broken
          checks.default = inputs.nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule nixvimModule;

          # Lets you run `nix run` to start nixvim
          packages = {
            default = nvim;
            avi = nvim;
          };

          formatter = pkgs.nixfmt;
        };
    };
}
