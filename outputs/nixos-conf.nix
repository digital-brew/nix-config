{ inputs, system, pkgs, extraArgs, ... }:

with inputs;

let
  inherit (nixpkgs.lib) nixosSystem;
  inherit (pkgs) lib;

  tongfangModules = [
    ../system/machine/tongfang-amd
    ../system/configuration.nix
  ];

  edpHomeModules =
    let
      extraSpecialArgs = extraArgs { hidpi = false; };
    in
    [
      home-manager.nixosModules.home-manager
      (import ./home-module.nix { inherit inputs system extraSpecialArgs; })
    ];

  vmUser = {
    users.users.gvolpe.initialPassword = "test";
  };
in
{
  dell-xps = nixosSystem {
    inherit lib pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/dell-xps
      ../system/configuration.nix
    ];
  };

  tongfang-amd = nixosSystem {
    inherit lib pkgs system;
    specialArgs = { inherit inputs; };
    modules = tongfangModules;
  };

  edp-tongfang-amd = nixosSystem {
    inherit lib pkgs system;
    specialArgs = { inherit inputs; };
    modules = tongfangModules ++ edpHomeModules ++ [ vmUser ];
  };
}
