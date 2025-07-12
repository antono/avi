{
  keymaps = [
    {
      mode = [
        "n"
        "u"
        "d"
      ];
      key = "s";
      action = {
        __raw = ''
          local diagnostics_active = true
          vim.keymap.set('n', '<leader>ud', function()
            diagnostics_active = not diagnostics_active
            if diagnostics_active then
              vim.diagnostic.show()
            else
              vim.diagnostic.hide()
            end
          end, { desc = "Toggle diagnostics" })
        '';
      };
      options.desc = "Flash";
    }
  ];
}
