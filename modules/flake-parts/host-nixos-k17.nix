{ inputs, ... }:
{
  flake.nixosConfigurations.nixos-k17 = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      {
        networking.hostName = "nixos-k17"; # Define your hostname.
      }
      inputs.self.modules.nixos.main-configuration
      inputs.self.modules.nixos.hardware-nucbox-k17
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          users.steven = inputs.self.modules.homeManager.home-steven;
        };
      }
    ];
  };
}
