{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=26.05";

  };

  outputs = { self, nixpkgs }: {
        nixosConfigurations.nixos-steven = nixpkgs.lib.nixosSystem {
            modules = [ ./configuration.nix ];
    };
  };
}
