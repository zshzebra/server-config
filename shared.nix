{ config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  time.timeZone = "Australia/Sydney";

  services.xserver.xkb.layout = "us";

  users.users.zshzebra = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
      fastfetch
    ];
  };

  system.userActivationScripts.zshrc = "touch .zshrc";

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = ["git" "sudo" "docker" "kubectl" ];
    };

    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  environment.pathsToLink = ["/share/zsh"];

  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    zsh-powerlevel10k
    git
  ];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  services.openssh.enable = true;

  services.kmscon = {
    enable = true;
    fonts = [ { name = "JetBrains Mono NF"; package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }); } ];
  };

  networking.firewall = {
    allowPing = true;
    allowedTCPPorts = [ 22 ];
  };

  system.stateVersion = "24.11";
}
