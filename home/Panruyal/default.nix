{ home-manager, ... }:
{
  imports = [
    ../.
    ../hypr.nix
    ../waybar
    ../cli
  ];

  dbConfig = {
    cli = true;
  };

}
