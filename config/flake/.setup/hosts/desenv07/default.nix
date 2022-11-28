{ config, pkgs, user, ... }:

{
  imports =                                               # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    (import ../../modules/virtualization) ++
    [import ../../modules/desktop/awesome/default.nix];   # virtualization

  boot = {                                  # Boot options
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {                              # EFI Boot
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {                              # Most of grub is set up for dual boot
        enable = true;
        version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                 # Find all boot options
        configurationLimit = 2;
      };
      timeout = 1;                          # Grub auto select time
    };
  };

  hardware.sane = {                           # Used for scanning with Xsane
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  environment = {
    systemPackages = with pkgs; [
      simple-scan
    ];
  };

  programs = {                              # No xbacklight, this is the alterantive
    dconf.enable = true;
    light.enable = true;
  };

  services = {
#   printing = {                            # Printing and drivers for TS5300
#     enable = true;
#     drivers = [ pkgs.cnijfilter2 ];
#   };
    avahi = {                               # Needed to find wireless printer
      enable = true;
      nssmdns = true;
      publish = {                           # Needed for detecting the scanner
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
    samba = {
      enable = true;
      shares = {
        share = {
          "path" = "/home/${user}/Public";
          "guest ok" = "no";
          "read only" = "no";
        };
      };
      openFirewall = true;
    };
    xserver = {
      resolutions = [
        { x = 1600; y = 920; }
        { x = 1280; y = 720; }
        { x = 1920; y = 1080; }
      ];
    };
  };
}
