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
            overlays = [
              (final: prev: {
                vimPlugins = prev.vimPlugins.extend (
                  _: vprev: {
                    # Upstream re-tagged v3.0.4, so nixpkgs' hash no longer matches.
                    # Pin the commit the tag now points to; drop once nixpkgs is fixed.
                    copilot-lua = vprev.copilot-lua.overrideAttrs (_: {
                      src = prev.fetchFromGitHub {
                        owner = "zbirenbaum";
                        repo = "copilot.lua";
                        rev = "9d391a02dc0281713cbb7c3bc87cdd38287b92eb";
                        hash = "sha256-kDQOm7/N6T7wOw1JlkcxNMnQrDE4oTRyGCZkvT8HZQw=";
                      };
                    });
                  }
                );
              })
            ];
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
