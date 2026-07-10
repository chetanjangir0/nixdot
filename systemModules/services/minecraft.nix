{ pkgs, ... }:
{
  services.tailscale.enable = true;

  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    declarative = false;

    package = pkgs.papermc;

    serverProperties = {
      server-port = 25565;
      gamemode = "survival";
      difficulty = "normal";
      max-players = 10;
      motd = "Chetan's Server";
      online-mode = true;
    };
  };

  networking.firewall.allowedUDPPorts = [ 19132 ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
