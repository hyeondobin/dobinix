{ ... }:
{
  imports = [
    ./fish.nix
    ./eza.nix
    ./zoxide.nix
  ];

  programs.direnv = {
    enable = true;
    # enableFishIntegration = true;
    nix-direnv.enable = true;
  };
}
