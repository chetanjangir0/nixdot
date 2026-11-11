{ inputs, username, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
    defaultUser = username;

    # Interop with Windows
    interop.includePath = true;
  };

  # Disable NetworkManager as WSL handles networking through the Windows virtual switch
  networking.networkmanager.enable = false;
}
