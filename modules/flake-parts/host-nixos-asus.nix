{ inputs, ... }:
{
  flake.nixosConfigurations.nixos-asus = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      {
        networking.hostName = "nixos-asus"; # Define your hostname.
      }
      inputs.self.modules.nixos.main-configuration
      inputs.self.modules.nixos.hardware-asus
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
