{ ... }:
{
  programs.eza = {
    enable = true;
    colors = "always";
    enableFishIntegration = true;
    icons = "always";
    git = true;
    extraOptions = [
      "--long"
      "--all"
      "--header"
    ];
  };
}
