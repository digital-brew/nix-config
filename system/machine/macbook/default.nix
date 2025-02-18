{ config, pkgs, ... }:

{
  imports =  [
    # Hardware scan
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the GRUB 2 boot loader.
#   boot = {
#     kernelPackages = pkgs.linuxPackages_latest;
#     loader = {
#       grub = {
#         enable  = true;
#         device = "/dev/sda"; # or "nodev" for efi only
#       };
#     };
#   };

  networking = {
    hostName = "DBi9XRL";
    interfaces.wlp2s0.useDHCP = true;
  };

#  fileSystems."/data" = {
#    device = "/dev/nvme0n1p3";
#    fsType = "ext4";
#  };

  services.xserver = {
    xrandrHeads = [
      { output = "eDP-1";
        primary = true;
        monitorConfig = ''
          Option "PreferredMode" "1440x900"
          Option "Position" "0 0"
        '';
      }
#      { output = "eDP-1";
#        monitorConfig = ''
#          Option "PreferredMode" "3840x2160"
#          Option "Position" "0 0"
#        '';
#      }
    ];
    resolutions = [
      { x = 2048; y = 1152; }
      { x = 1440; y = 900; }
      { x = 1920; y = 1080; }
      { x = 2560; y = 1440; }
      { x = 3072; y = 1728; }
      { x = 3840; y = 2160; }
    ];
  };
}
