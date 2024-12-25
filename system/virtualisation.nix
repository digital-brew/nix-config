{ pkgs, ... }:

# docs: https://nixos.wiki/wiki/NixOS:nixos-rebuild_build-vm
{
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [ quickemu ];

  users = {
    groups.nixosvmtest = { };
    groups.libvirtd.members = [ "gvolpe" ];

    users.vmtest = {
      isSystemUser = true;
      initialPassword = "test";
      group = "nixosvmtest";
    };
  };

  virtualisation = {
    # virtual manager for vms
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 4;
    };
  };
}
