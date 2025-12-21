{
  inputs,
  lib,
  pkgs,
  config-vars,
  ...
}:
{
  imports = [
    inputs.wsl.nixosModules.default
    ./git.nix
  ];
  wsl.enable = true;
  wsl.defaultUser = "hyeondobin";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  networking.hostName = config-vars.hostname;

  environment.systemPackages = [
    inputs.nxim.packages.${config-vars.system}.nxim
    # inputs.nxim.packages.${stdenv.hostPlatform.system}.regularCats
    pkgs.git
    pkgs.lazygit
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = config-vars.stateVersion;
}
