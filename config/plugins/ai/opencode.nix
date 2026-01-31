{ config, lib, ... }:
{
  plugins.opencode = {
    enable = false;
    settings = {
      auto_reload = false;
      port = 8080;
      prompts = {
        example = {
          description = "An example prompt configuration";
          prompt = "Write a function that returns the factorial of a number";
        };
      };
    };
  };
}
