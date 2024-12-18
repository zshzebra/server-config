{ config, lib, pkgs, ... }: {
  imports = [ ../shared.nix ];
  
  networking.hostName = "nixserver2";
}
