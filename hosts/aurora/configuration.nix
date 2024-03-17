# NixOS config with flakes and home-manager. Very messy.

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
  ];

  # Support for Flakes and commands, Unfree
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Gnome polkit
  security.polkit.enable = true;
  systemd = {
     user.services.polkit-gnome-authentication-agent-1 = {
       description = "polkit-gnome-authentication-agent-1";
       wantedBy = ["graphical-session.target"];
       wants = ["graphical-session.target"];
       after = ["graphical-session.target"];
       serviceConfig = {
         Type = "simple";
         ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
         Restart = "on-failure";
         RestartSec = 1;
         TimeoutStopSec = 10;
      };
    };
  }; 

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # Power Management for battery life
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_MIN_PERF_ON_AC = 0; 
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

    };
  };

  # Network
  networking = {
    hostName = "aurora";
    networkmanager.enable = true;
  };

  # Timezone and locale
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Xserver and graphics
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
      nvidia = {
        modesetting.enable = true;
	nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.stable;
        prime = {
	  offload.enable = true;
	  offload.enableOffloadCmd = true;
	  intelBusId = "PCI:0:2:0";
	  nvidiaBusId = "PCI:1:0:0";
	};
      };

};

  # Display Manager and autologin
#  services.xserver.displayManager = {
#      sddm = {
#          enable = true;
#          settings = {
#              AutoLogin = {
#                  Session = "hyprland";
#                  User = "ghil";
#                };
#            };
#        };
#    };

# Enable the WM
#  programs.hyprland.enable = true;
#  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
#
#  services.desktopManager.plasma6.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

# Keymap
  services.xserver.xkb = {
    layout = "us,ca";
    variant = "fr";
    options = "grp:win_space_toggle";
  };

  # Sound - Pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # NixOS Options
  programs.zsh.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      powerline-fonts
      powerline-symbols
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override {fonts = ["Meslo"];})
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
  };
  
  # Userland
  users.users.ghil = {
    isNormalUser = true;
    description = "ghil";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };

  #Home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ghil" = import ./home.nix;
    };
  };

  # Packages installed system wide
  environment.systemPackages = with pkgs; [
    acpi
    appimage-run
    distrobox
    fastfetch
    git
    gcc
    kitty
    lazygit
    libgcc
    neovim
    nerdfonts
    ripgrep
    wl-clipboard
    wget
];

environment.sessionVariables = {
  WLR_NO_HARDWARE_CURSORS = "1";
  NIXOS_OZONE_WL = "1";
};

  system.stateVersion = "23.11"; # Did you read the comment?

}
