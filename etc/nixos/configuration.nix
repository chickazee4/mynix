{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  # Localization
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Desktop environment
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # CUPS printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  # Sound - via PipeWire
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    media-session.config.bluez-monitor.rules = [
        {
        # Matches all cards
        matches = [ { "device.name" = "~bluez_card.*"; } ];
        actions = {
            "update-props" = {
            "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
            # mSBC is not expected to work on all headset + adapter combinations.
            "bluez5.msbc-support" = true;
            # SBC-XQ is not expected to work on all headset + adapter combinations.
            "bluez5.sbc-xq-support" = true;
            };
        };
        }
        {
        matches = [
            # Matches all sources
            { "node.name" = "~bluez_input.*"; }
            # Matches all outputs
            { "node.name" = "~bluez_output.*"; }
        ];
        actions = {
            "node.pause-on-idle" = false;
        };
        }
    ];
  };

  # Boot settings (with GRUB)
  boot.initrd.supportedFilesystems = [ "btrfs" ];
  boot.kernelParams = [ "nohibernate" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.copyKernels = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.theme = "/boot/grub/themes/nix";
  boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = true;
  boot.plymouth.enable = true;
  boot.supportedFilesystems = [ "btrfs" ];
  fileSystems."/usr".device = "/dev/disk/by-uuid/0800db86-dde5-4ae0-bb89-7dc30f5b39f5";

  # me - change this if your name is not lyndsay
  users.users.lyndsay = {
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" ];
     home = "/usr/lyndsay"; # the /home directory is retarded and useless!!
  };

  # software
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "lyndsay" ];
  programs.steam.enable = true;
  nixpkgs.config.vivaldi = { proprietaryCodecs = true; enableWideVine = true; };

  nixpkgs.config.permittedInsecurePackages = [
    "ffmpeg-3.4.8"
  ];

  environment.systemPackages = with pkgs; [
     ark
     audacity
     blender
     citra
     cmake
     discord
     desmume
     dolphinEmu
     fontforge
     gimp
     git
     gwenview
     inkscape
     k3b
     kate
     kcalc
     keepassxc
     kdeconnect
     latte-dock
     libreoffice-qt
     libsForQt5.applet-window-buttons
     libsForQt5.qtquickcontrols
     libsForQt5.qtstyleplugin-kvantum
     lmms
     musescore
#     natron       # currently disabled bc openfx doesn't build properly
     neofetch
     okular
     openshot-qt
     pavucontrol
     rstudio
     spotify
     texworks
     thunderbird
     vivaldi-widevine
     vivaldi-ffmpeg-codecs
     vivaldi
     vscode
     wget
     wineWowPackages.full
     zoom
  ];
}

