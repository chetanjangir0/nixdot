{ ... }:

{
  virtualisation.docker.enable = true;

  users.users.chetan.extraGroups = [
    "docker"
  ];
}
