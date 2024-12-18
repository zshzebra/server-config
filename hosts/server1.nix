{ config, lib, pkgs, ... }: {
  imports = [ ../shared.nix ];
  
  networking.hostName = "nixserver1";
}
