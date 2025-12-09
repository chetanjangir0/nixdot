{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (winboat.overrideAttrs (oldAttrs: {
      makeCacheWritable = true;
      npmFlags = [ "--legacy-peer-deps" ];
    }))
  ];
}
