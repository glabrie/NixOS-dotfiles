# Ghil's NixOS config. Current setup does not support flakes or home-manager.

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./main-user.nix
      inputs.home-manager.nixosModules.default
  ];
  
  main-user.enable = true;
  main-user.userName = "ghil";

  # Support for Flakes and commands
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Polkit?
  security.polkit.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NixOS is pretty good at being legible, but in case you forget...networking.
  networking = {
    hostName = "erebor";
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
  
  # Enable automatic login for the user.
  services.xserver.displayManager = {
    lightdm.enable = true;
    autoLogin = {
      enable = true;
      user = "ghil";
      };
    };

# Enable the WM
  programs.hyprland.enable = true;

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
  programs.steam.enable = true;
  programs.htop.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
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
    description = "Guillaume Labrie";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      cliphist
      dmenu
      element-desktop
      firefox
      floorp
      google-chrome
      hyprpaper
      slack
      telegram-desktop
      xfce.thunar
      vscode
      waybar
      wofi
      wpsoffice
    ];
  };

  home-manager = {
    #also pass inputs to home-manager module
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ghil" = import ./home.nix;
    };
  };

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

  system.stateVersion = "23.11"; # Did you read the comment?

}
