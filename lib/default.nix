{ inputs, lib, pkgs, ... }:

let
  inherit (lib) makeExtensible attrValues foldr;
  inherit (modules) mapModule;

  modules = import ./modules.nix {
    inherit lib;
    self.attrs = import ./attrs.nix {
      inherit lib;
      self = { };
    };
  };

  mylib = makeExtensible (self:
    with self;
    mapModule (file: import file { inherit self inputs lib pkgs; }) ./.);
in mylib.extend (self: super: foldr (a: b: a // b) { } (attrValues super))
