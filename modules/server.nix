{ config, pkgs, ... }:

{
  users.users.leon = {
    isNormalUser = true;
    description = "Leon";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      python3
      python312Packages.tqdm
      python312Packages.psutil
      yt-dlp
      sqlite
      ffmpeg
    ];
  };

  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
}
