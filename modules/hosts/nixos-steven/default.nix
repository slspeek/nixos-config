{ inputs, ... }:
{
  flake.nixosConfigurations.nixos-steven = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      ./configuration.nix
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          users.steven = import ./home.nix;
        };
      }
    ];
  };
}
