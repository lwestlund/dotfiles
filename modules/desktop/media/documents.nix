{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.documents;
in {
  options.modules.desktop.media.documents = {
    enable = mkBoolOpt false;
    ebook.enable = mkBoolOpt false;
    pdf.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      (mkIf cfg.ebook.enable calibre)
      # TODO: Maybe change to a different PDF reader like zathura.
      (mkIf cfg.pdf.enable evince)
    ];
  };
}
