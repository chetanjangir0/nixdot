# homeModules/programs/zsh.nix
{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };

    sessionVariables = {
      VISUAL = "nvim";
      KEYTIMEOUT = "1";
    };

    initContent = ''
      # Vi mode
      bindkey -v

      # Sessionizer shortcut
      bindkey -s ^f "tmux-sessionizer\n"

      # Custom binary paths
      export PATH="$HOME/.cargo/bin:$HOME/scripts:/usr/local/go/bin:/opt/zig:$PATH"
    '';

    shellAliases = {
      la = "ls -a";
      fs = "yazi";
      ff = "fastfetch";
      vim = "nvim";
      ta = "tmux attach";
      lg = "lazygit";
      music = "termusic";
      bb = "blueboy";
      opp = "onepdfplease";
      bt = "bluetoothctl connect 98:47:44:15:9D:6A";
      nix-shell = "NIXPKGS_ALLOW_UNFREE=1 nix-shell";

      # Git aliases
      gs = "git status --short";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gp = "git push";
      gu = "git pull";
      gl = "git log";
      gb = "git branch";
      gi = "git init";
      gcl = "git clone";
      gk = "git add . && git commit -m \"changes\" && git push";
    };
  };
}
