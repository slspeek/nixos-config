{ inputs, ... }:
{
  flake.nixosConfigurations.nixos-k17 = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      {
        users.users."steven".extraGroups = [
          "render"
          "video"
        ];
        networking.hostName = "nixos-k17"; # Define your hostname.
        environment.sessionVariables = {
          ZE_ENABLE_ALT_DRIVERS = "libze_intel_npu.so";
        };
        services.ollama = {
          enable = true;
          environmentVariables = {
            OLLAMA_VULKAN = "1";
          };
        };
        environment.systemPackages = with inputs.nixpkgs.legacyPackages.x86_64-linux.pkgs; [
          openvino
          clinfo
        ];
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
