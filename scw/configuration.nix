{ ... }: {
  imports = [
    ./hardware.nix
    ./system.nix
    ./network.nix
    ./user.nix
    ./server.nix
  ];
}
