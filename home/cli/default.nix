{ ... }:
{
  imports = [
    ./eza.nix
    ./fish.nix
    ./ghostty.nix
    ./zoxide.nix
  ];

  programs.direnv = {
    enable = true;
    # enableFishIntegration = true;
    nix-direnv.enable = true;
  };
}
