let
  nixpkgs = import ./nixpkgs-with-rust.nix;
in
nixpkgs.latest.rustChannels.stable.rust
