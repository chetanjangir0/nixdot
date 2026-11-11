{
  inputs,
  pkgs,
  config,
  ...
}:
let
  username = "chetan";
in
{

  programs.home-manager.enable = true;

  imports = [
    ./homeModules/programs/zsh.nix
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    packages = with pkgs; [
      # CLI workflow tools
      fastfetch
      yazi
      tmux
      bat
      fzf
      ripgrep
      lazygit
      croc
      tealdeer
      posting
      nix-search
      tree

      # Custom packages
      blueboy
      onepdfplease

      # Development & Editor
      neovim
      tree-sitter
      gcc
      gnumake

      # Languages
      nodejs
      go
      typst
      rustc
      cargo
      rust-analyzer
      rustfmt
      clippy
      python3
      pyright
      black

      # Language servers & formatters
      lua-language-server
      typescript-language-server
      gopls
      tinymist
      tailwindcss-language-server
      marksman
      nil
      svelte-language-server
      stylua
      prettier
      nixfmt
      eslint
    ];
  };

}
