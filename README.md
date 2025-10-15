<h1 align="center">
    <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg" width="96px" height="96px" />
    <br>
    avi (based on Akari)
</h1>

<p align=center>Standalone Nixvim flake based on Lazyvim with some more changes.</p>

---

</div>

# 🔨 Installation

If you'd like to give it a try before installing: `nix run github:antono/avi`

### Adding it as a flake

1: Go to the flake.nix and add `avi.url = "github:antono/avi"` to your inputs.

```nix
# flake
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    avi.url = "github:antono/avi";
  };
}
```

2: Run nix flake update

3: Install it by adding `inputs.avi.packages.${system}.default` to your
environment.systemPackages or home.packages. If you're using home-manager.

```nix
# packages
{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.avi.packages.${system}.default
  ];
}
```

4: Rebuild your system.

</details>

# ⚙️ Configuration

To start configuring, add or modify the nix files in `./config`. If you add a
new configuration file, remember to add it to the
[`config/default.nix`](./config/default.nix) file

## Testing your new configuration

To test your configuration simply run the following command

```
nix run .
```

# :bookmark_tabs: Resources

Some Nixvim setups that I use from.

- [spector700/Akari](https://github.com/spector700/Akari)
- [khaneliman/khanelivim](https://github.com/khaneliman/khanelivim/tree/main)
- [niksingh710/nvix](https://github.com/niksingh710/nvix)
