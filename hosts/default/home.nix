{ config, pkgs, ... }:

{
  home.username = "ghil";
  home.homeDirectory = "/home/ghil";
  home.stateVersion = "23.11"; # do not change please.
 
  # GTK
    gtk = {
      enable = true;
      font.name = "TeX Gyre Adventor 10";
      theme = {
        name = "Catppuccin-Mocha-Compact-Mauve-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "compact";
          tweaks = [ "rimless" "black" ];
          variant = "mocha";
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
        };

      gtk3.extraConfig = { 
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
      };

      gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
      };

   };
  #gnome outside gnome
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
	theme = "Catppuccin-Mocha-Compact-Mauve-Dark";
      };
    };
  };
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    bibata-cursors
    bottom
    catppuccin
    catppuccin-gtk
    catppuccin-cursors
    catppuccin-sddm-corners
    cliphist
    dmenu
    dunst
    element-desktop
    floorp
    gh
    google-chrome
    grimblast
    hyprpaper
    juno-theme
    ncspot
    papirus-icon-theme
    polkit_gnome
    ranger
    rofi-wayland
    slack
    telegram-desktop
    xfce.thunar
    waybar
    w3m
    wpsoffice
 ];

  home.file = {

  };

  home.sessionVariables = {
     EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
    };
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      flup = "nix flake update";
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles/#default";
      collect-garbage = "nix-collect-garbage -d";
      boot-garbage = "sudo /run/current-system/bin/switch-to-configuration boot";
    };
};

}
