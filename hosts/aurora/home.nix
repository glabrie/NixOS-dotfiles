{ config, pkgs, ... }:

{
  home.username = "ghil";
  home.homeDirectory = "/home/ghil";
  home.stateVersion = "23.11"; # do not change please.
 
  # GTK
#    gtk = {
#      enable = true;
#      font.name = "TeX Gyre Adventor 10";
#      theme = {
#        name = "Catppuccin-Mocha-Compact-Mauve-Dark";
#        package = pkgs.catppuccin-gtk.override {
#          accents = [ "mauve" ];
#          size = "compact";
#          tweaks = [ "rimless" "black" ];
#          variant = "mocha";
#        };
#      };
#      iconTheme = {
#        name = "Papirus-Dark";
#        package = pkgs.papirus-icon-theme;
#      };
#      cursorTheme = {
#          name = "Bibata-Modern-Classic";
#          package = pkgs.bibata-cursors;
#        };
#
#      gtk3.extraConfig = { 
#      Settings = ''
#        gtk-application-prefer-dark-theme=1
#        gtk-cursor-theme-name=Bibata-Modern-Classic
#      '';
#      };
#
#      gtk4.extraConfig = {
#      Settings = ''
#        gtk-application-prefer-dark-theme=1
#       gtk-cursor-theme-name=Bibata-Modern-Classic
#      '';
#      };
#
#   };
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
    atuin
    bibata-cursors
    bottom
    catppuccin
    catppuccin-gtk
    catppuccin-kde
    catppuccin-kvantum
    catppuccin-cursors
    catppuccin-sddm-corners
    cava
    cliphist
    discord
    dmenu
    dunst
    element-desktop
    floorp
    gh
    google-chrome
    grimblast
    hyprpaper
    juno-theme
    kde-rounded-corners
    ncspot
    papirus-icon-theme
    polkit_gnome
    qt6Packages.qtstyleplugin-kvantum
    ranger
    rofi-wayland
    slack
    telegram-desktop
    xfce.thunar
    vscode-with-extensions
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
      boot-garbage = "sudo /run/current-system/bin/switch-to-configuration boot";
      collect-garbage = "nix-collect-garbage -d";
      dots ="cd ~/.dotfiles/";
      flup = "nix flake update";
      ga = "git add *";
      gc = "git commit --verbose";
      gp = "git push";
      ll = "ls -l";
      v = "nvim";
      update = "sudo nixos-rebuild switch --flake ~/.dotfiles/#default";
    };
};

}
