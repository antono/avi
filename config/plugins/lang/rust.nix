{
  # rust-analyzer/rustfmt come from the project's devshell (direnv), so the
  # toolchain version always matches the project
  dependencies.rust-analyzer.enable = false;

  plugins = {
    rustaceanvim = {
      enable = true;
    };
    crates.enable = true;
  };
}
