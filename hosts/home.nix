{ config, lib, ... }:

with lib; {
  networking.hosts = let
    hostConfig = {

    };
    hosts = flatten (attrValues hostConfig);
    hostName = config.networking.hostName;
  in mkIf (builtins.elem hostName hosts) hostConfig;

  # Location config.
  time.timeZone = mkDefault "Europe/Stockholm";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";
  location = {
    latitude = 57.7156;
    longitude = 11.9783;
  };
}
