# Modules
{ config, lib, pkgs, callPackage, inputs, unstable, ... }:

# Imports
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader config
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking config
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # Locale config
  time.timeZone = "Europe/Belfast";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  # Environment config
  environment = {
    pathsToLink = [ "/libexec" ];
    sessionVariables = {
      EDITOR = [ "nano" ];
    };
  };

  # User config
  users.users.hamish = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
  };

  security.sudo.extraRules = [{
      users = [ "hamish" ];
      commands = [{ command = "ALL";
        options = [ "NOPASSWD" ];
        }];
  }];

  # Package config
  environment.systemPackages = with pkgs; [
    wget
    git
    pkgs.nix-ld
    curl
  ];

  # Service config
  programs.nix-ld.enable = true;
  services.openssh.enable = true;

  # Nixos version
  system.stateVersion = "24.05";

}