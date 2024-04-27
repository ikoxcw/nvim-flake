{ pkgs, helpers, ... }:
let
  importPlugin = name: import ./lazy_plugins/${name}.nix { inherit pkgs helpers; };
  category = {
    theme = "nord-nvim";
    filetree = "nvim-tree-lua";
    terminal = "toggleterm-nvim";
    tabline = "bufferline-nvim";
    statusline = "lualine-nvim";
    motion = "flash-nvim";
    keybinding = "which-key-nvim";
    indent = "indent-blankline-nvim";
    git = [
      "gitsigns-nvim"
      # "neogit"
      "diffview-nvim"
    ];
    fuzzy_finder = [
      "telescope-nvim"
    ];
    debug = [
      "nvim-dap"
      "nvim-dap-ui"
      "nvim-dap-go"
      "nvim-dap-virtual-text"
    ];
    syntax = [
      "nvim-treesitter"
      "vim-nix"
      "nvim-ts-context-commentstring"
      "rainbow-delimiters-nvim"
    ];
    completion = "nvim-cmp";
    lsp = [
      "nvim-lspconfig"
      "lspsaga-nvim"
      "trouble-nvim"
      "none-ls-nvim"
    ];
    utils = [
      "undotree"
      "nvim-surround"
      "noice-nvim"
      "nvim-autopairs"
      "todo-comments-nvim"
      "markdown-preview-nvim"
      "comment-nvim"
    ];
  };
  plugins = builtins.concatMap (cat: map importPlugin (if builtins.isList cat then cat else [ cat ])) (builtins.attrValues category);
in
{
  imports = [
    ./base
  ];
  config = {
    plugins.lazy = {
      inherit plugins;
      enable = true;
    };
  };
}
