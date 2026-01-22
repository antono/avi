# AGENTS.md

This file contains guidelines and commands for agentic coding agents working in the AVI repository.

## Project Overview

AVI is a Nixvim-based Neovim configuration using the Nix ecosystem for reproducible development environments. The configuration is modular, organized by plugin categories, and emphasizes declarative configuration.

## Build/Lint/Test Commands

### Core Commands
```bash
nix run .                    # Run the editor with current config
nix flake check              # Validate configuration integrity
nix flake update             # Update flake inputs
nix run github:antono/avi    # Run remote version
```

### Code Quality Tools
- **Format on save**: Configured via conform.nix
- **Python**: Uses ruff for linting and formatting
- **Rust**: Uses rustfmt for formatting
- **Spell checking**: typos-lsp integration
- **Nix**: Built-in validation via `nix flake check`

### Testing
No dedicated test framework. Configuration validation is handled by:
- `nix flake check` - Validates Nix expressions and dependencies
- Manual testing via `nix run .`

## Code Style Guidelines

### Nix Expressions
- Use 2-space indentation
- Follow functional programming patterns
- Keep expressions pure and declarative
- Use descriptive variable names
- Organize imports logically (core → plugins → utilities)

### File Organization
```
config/
├── default.nix          # Main entry point
├── settings.nix         # Neovim options
├── keymaps.nix          # Key bindings
├── autocmd.nix          # Auto commands
└── plugins/             # Modular plugin configs
    ├── ai/             # AI integrations
    ├── completion/     # Completion engines
    ├── editor/         # Editor enhancements
    ├── lsp/            # Language server configs
    ├── lang/           # Language-specific configs
    ├── theme/          # Color schemes
    ├── ui/             # UI components
    └── util/           # Utility plugins
```

### Plugin Configuration
- Group plugins by functionality in separate files
- Use consistent naming: `{category}/{plugin-name}.nix`
- Enable plugins conditionally based on use case
- Provide clear descriptions for keymaps
- Use lazy loading for performance

### Keymap Conventions
- Leader key: `<space>`
- Use descriptive names for keymap descriptions
- Group related keymaps by prefix (e.g., `<leader>g` for git)
- Include mode information (`n`, `i`, `v` for normal/insert/visual)
- Document non-obvious keybindings in comments

### Import Patterns
```nix
# Standard import structure
{
  imports = [
    ./settings.nix
    ./keymaps.nix
    ./autocmd.nix
    ./plugins/ai
    ./plugins/completion
    ./plugins/editor
    # ... other categories
  ];
}
```

### Error Handling
- Use `lib.optionalAttrs` for conditional configuration
- Validate plugin compatibility before enabling
- Handle missing dependencies gracefully
- Use `mkIf` for feature flags

### Naming Conventions
- Files: kebab-case (e.g., `code-companion.nix`)
- Variables: camelCase for Nix expressions
- Plugins: use upstream name consistently
- Functions: descriptive names with clear purpose

## Language-Specific Guidelines

### Nix
- Use `lib.` functions for list/string operations
- Prefer `mkIf` over nested conditionals
- Keep expressions composable
- Document complex logic with comments

### Lua (when embedded)
- Use 2-space indentation
- Prefer local variables
- Use vim.api functions over vim.commands
- Handle errors with pcall()

## AI Integration Guidelines

### Available AI Tools
- **CodeCompanion**: Primary AI assistant (enabled)
- **Copilot**: GitHub Copilot integration (configured)
- **OpenCode**: OpenCode AI assistant (configured)
- **Windsurf**: Windsurf AI (configured)

### AI Keybindings
- `<leader>ac`: Toggle CodeCompanion chat
- `<leader>aa`: Open action palette
- `<leader>ae`: Explain code
- `<leader>af`: Fix code
- `<leader>am`: Clear memory
- `<leader>at`: Generate tests (visual mode)

### AI Usage Patterns
- Use CodeCompanion for code generation and explanations
- Leverage AI for boilerplate code and documentation
- Generate tests with visual selection + `<leader>at`
- Clear AI memory between different contexts

## Development Workflow

1. **Make changes**: Edit relevant plugin files
2. **Validate**: Run `nix flake check`
3. **Test**: Run `nix run .` to verify
4. **Update**: Run `nix flake update` when needed

## Common Patterns

### Adding New Plugins
1. Create file in appropriate `plugins/` subdirectory
2. Configure plugin with sensible defaults
3. Add keymaps if needed
4. Import in `config/default.nix`

### Language Server Configuration
- Add to `config/plugins/lsp/`
- Configure in `config/plugins/lang/{language}.nix`
- Include in `extraPackages` if external binary needed

### Conditional Features
```nix
config = mkIf (cfg.enableFeature) {
  plugins.example = {
    enable = true;
    # ... configuration
  };
};
```

## Dependencies

The project uses Nix flakes for dependency management. All external tools are declared in `extraPackages` in `config/default.nix`. Avoid adding dependencies via other package managers.

## Notes

- Treesitter is currently disabled due to compatibility issues
- Some plugins may be disabled if they depend on Treesitter
- Configuration is cross-platform via Nix
- All changes should be validated with `nix flake check`