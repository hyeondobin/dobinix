{ home-manager, ... }:
{
  imports = [
    ../.
    ../hypr.nix
    ../waybar
    ../cli
  ];

}
