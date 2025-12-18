{
  description = "hyeondobin's Nix OS configuration";

  outputs =
    {
      hive,
      std,
      ...
    }@inputs:
    hive.growOn
      {
        inherit inputs;

        nixpkgsConfig.allowUnfree = true;

        cellsFrom = ./cells;
        cellBlocks =
          with std.blockTypes;
          with hive.blockTypes;
          [
            (functions "bees")
            nixosConfigurations
            homeConfigurations
          ];
      }
      {
      };

  # Hive inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hive = {
      url = "github:divnix/hive";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:divnix/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # my inputs
  inputs = {
    nxim = {
      url = "github:hyeondobin/nxim";
    };
  };
}
