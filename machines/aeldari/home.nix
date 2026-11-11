{ pkgs, ... }:

{
  imports = [
    ../../homeModules/programs/zen-browser.nix
  ];

  home.packages = with pkgs; [
    # GUI & Media
    obsidian
    mpv
    zathura
    nsxiv
    sioyek
    antigravity-hub
    obs-studio
    ffmpeg

    # Tools & Development on this machine
    ncdu
  ];
}
