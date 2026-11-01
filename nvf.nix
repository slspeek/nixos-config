{}:{
  programs.nvf = {
    enable = true;
    # your nvf settings here...
    settings = {
      vim.theme.enable = true;
      vim.viAlias= true;
      vim.vimAlias = true;

      vim.nrs
      # Basic editor UI and behavior options
      vim.options = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
      };

      # Enable core features
      vim.telescope.enable = true;
      vim.statusline.lualine.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;

      # Enable Nix language support (Treesitter, LSP, and Formatting)
      vim.languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # Nix language and diagnostics.
      nix.enable = true;
    };
      };
  };
}
