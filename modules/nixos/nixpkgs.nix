{ inputs, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = [
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
