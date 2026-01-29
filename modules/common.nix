{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  users.users.leon = {
    isNormalUser = true;
    description = "Leon";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.bash;
    packages = with pkgs; [
      neovim
      tmux
      alacritty
      kitty
      wofi
      #kdePackages.dolphin
      fish
      eza
      bat
      zoxide

      fd
      fzf
      ripgrep
      tree

      gnumake
      stow
      gcc
      nodejs_24
      lua
      python3

      ncdu
      dua
      nh
      lazygit

      htop
      iotop
      ranger
    ];
  };

  environment.systemPackages = with pkgs; [
    vim git curl wget unzip
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;
  #services.tailscale.enable = true;

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
