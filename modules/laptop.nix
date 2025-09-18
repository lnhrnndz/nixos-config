{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    feh
    sxhkd
    xcape
    xorg.xset
    xbanish
    dunst
    custom-st
    custom-dwm
    custom-dmenu
  ];


  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
    #libinput.naturalScrolling = true;
  };

  services.libinput.touchpad.naturalScrolling = true;

  # Hyprland
  programs.hyprland.enable = true;
  services.libinput.enable = true;
  hardware.graphics.enable = true;
  #services.xserver.videoDrivers = [ "intel" ];
  services.dbus.enable = true;
  programs.hyprland.xwayland.enable = true; # optional

}
