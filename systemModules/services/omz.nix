
{ pkgs, ... }:

{
  # oh my zsh
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # because the declarative omz was not respecting my dotfiles
  environment.shellInit = ''
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
       git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
    fi'';

}
