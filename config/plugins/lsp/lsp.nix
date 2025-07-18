{
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;

      servers = {
        typos_lsp = {
          enable = true;
          extraOptions = {
            init_options.diagnosticSeverity = "Hint";
          };
        };
        yamlls = {
          enable = true;
          settings = {
            schemaStore = {
              enable = false;
              url = "";
            };
          };
        };

        helm_ls = {
          enable = true;
        };

        lua_ls = {
          enable = true;
          settings.telemetry.enable = false;
        };

        # rust_analyzer = {
        #   enable = true;
        # };

        ts_ls.enable = true; # TS/JS
        cssls.enable = true;
        tailwindcss.enable = true;
        svelte.enable = true;
        pyright.enable = true;
        nil_ls.enable = true; # Nix
        dockerls.enable = true; # Docker
        bashls.enable = true;
      };

      keymaps.lspBuf = {
        "<c-k>" = "signature_help";
        "gi" = "implementation";
        "gd" = {
          action = "definition";
          desc = "Goto Definition";
        };
        "gr" = {
          action = "references";
          desc = "Goto References";
        };
        "<leader>cr" = {
          action = "rename";
          desc = "Rename";
        };
      };
    };
    lint.enable = true;

    lsp-signature.enable = true;
    lsp-lines.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cl";
      action = "<cmd>LspInfo<cr>";
      options.desc = "Lsp Info";
    }
  ];
}
