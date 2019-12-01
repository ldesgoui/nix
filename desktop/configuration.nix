# configuration.nix
{ ... }: {
  imports = [
    ./hardware.nix
    ./system.nix
    ./network.nix
    ./user.nix
  ];
}
