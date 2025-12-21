{
  description = "hyeondobin's Nix OS configuration";

  outputs =
    { self, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      forAllSystems = inputs.nixpkgs.lib.getAttrs systems;
      username = "hyeondobin";
      configuration = config-vars: {
        nixosConfiguration = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs config-vars;
          };
          modules = [
            inputs.catppuccin.nixosModules.catppuccin
            ./hosts/${config-vars.hostname}
          ];
        };
        homeConfiguration =
          system:
          inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.${system};
            extraSpecialArgs = {
              inherit
                self
                inputs
                outputs
                config-vars
                ;
            };
            modules = [
              inputs.catppuccin.homeManagerModules.catppuccin
              ./home/${config-vars.hostname}
            ];
          };
      };
      Panruyal = configuration {
        stateVersion = "25.11";
        hostname = "Panruyal";
        inherit username;
        userDesc = "Laptop";
      };
      Winix = configuration {
        stateVersion = "25.11";
        hostname = "Winix";
        inherit username;
        userDesc = "WSL from VanLioum";
      };
    in
    {
      packages = forAllSystems (system: import ./pkgs inputs.nixpkgs.legacyPackages.${system});
      formatter = forAllSystems (system: inputs.nixpkgs.legacyPackages.${system}.nixfmt);
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        Panruyal = Panruyal.nixosConfiguration;
        Winix = Winix.nixosConfiguration;
      };
      homeConfigurations = {
        "hyeondobin@Panruyal" = Panruyal.homeConfiguration "x86_64-linux";
        "hyeondobin@Winix" = Winix.homeConfiguration "x86_64-linux";
      };
    };

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

    nxim = {
      url = "github:hyeondobin/nxim";
    };
  };
}
