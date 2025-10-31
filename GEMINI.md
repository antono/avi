# Project Overview

This is a standalone Nixvim flake configuration named "avi", based on Lazyvim. It provides a reproducible Neovim environment managed by Nix, with a comprehensive set of plugins and configurations.

**Key Technologies:**

*   **Nix:** Used for dependency management and creating a reproducible environment.
*   **Nixvim:** A Nix module to configure Neovim.
*   **Lua:** The primary language for Neovim configuration.
*   **Neovim:** The text editor.

**Architecture:**

The configuration is structured around a central `flake.nix` file that defines the project's inputs and outputs. The main configuration is imported from the `config` directory, which is further modularized into settings, keymaps, plugins, and autocommands.

# Building and Running

*   **Run the editor with the current configuration:**
    ```bash
    nix run .
    ```

*   **Check for configuration errors:**
    ```bash
    nix flake check
    ```

# Development Conventions

## Configuration

*   The main configuration is in `config/default.nix`.
*   New configuration files should be added to the `imports` list in `config/default.nix`.
*   **Settings:** General Neovim settings are located in `config/settings.nix`.
*   **Keymaps:** Keybindings are defined in `config/keymaps.nix`.
*   **Plugins:** Plugins are managed in the `config/plugins/` directory. Each plugin has its own Nix file, and they are all imported into `config/plugins/default.nix`.

## Adding a New Plugin

1.  Create a new Nix file for the plugin in the appropriate subdirectory of `config/plugins/`.
2.  Add the plugin to the `plugins` list in the new file.
3.  Import the new file into `config/plugins/default.nix`.

## Keybinding Conventions

*   The leader key is set to the spacebar.
*   Keybindings are organized by function in `config/keymaps.nix`.
*   Window management shortcuts use `<C-Up>`, `<C-Down>`, `<C-Left>`, and `<C-Right>`.
*   The `<leader>` key is used for various shortcuts, including quitting, saving, and toggling options.
