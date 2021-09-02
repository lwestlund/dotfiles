{ self, lib, ... }:

let
  inherit (builtins) attrValues readDir pathExists concatLists;
  inherit (lib) hasPrefix hasSuffix removeSuffix nameValuePair;
  inherit (lib.attrsets) filterAttrs mapAttrsToList;
  inherit (lib.trivial) id;
  inherit (self.attrs) mapFilterAttrs;
in rec {
  # mapModule :: (Path -> Any) -> Path -> AttrSet
  #
  #   fn   Function to map over module files.
  #   dir  Directory of module to map.
  #
  # Map a function fn over a nix module or all nix files in Path dir.
  mapModule = fn: dir:
    let
      mapFn = (n: v:
        let path = "${toString dir}/${n}";
        in if v == "directory" && pathExists "${path}/default.nix" then
          nameValuePair n (fn path)
        else if v == "regular" && n != "default.nix" && hasSuffix ".nix" n then
          nameValuePair (removeSuffix ".nix" n) (fn path)
        else
          nameValuePair "" null);
      pred = (n: v: v != null && !(hasPrefix "_" n));
    in mapFilterAttrs mapFn pred (readDir dir);

  # mapModulesRec :: (Path -> Any) -> Path -> AttrSet
  #
  #   fn   Function to map over modules.
  #   dir  Directory to recursively map modules in.
  #
  # Map function fn over all nix files in Path dir.
  mapModulesRec = fn: dir:
    let
      mapFn = (n: v:
        let path = "${toString dir}/${n}";
        in if v == "directory" then
          nameValuePair n (mapModulesRec fn path)
        else if v == "regular" && n != "default.nix" && hasSuffix ".nix" n then
          nameValuePair (removeSuffix ".nix" n) (fn path)
        else
          nameValuePair "" null);
      pred = (n: v: v != null && !hasPrefix "_" n);
    in mapFilterAttrs mapFn pred (readDir dir);

  # mapModulesRec' :: (Path -> Any) -> Path -> [Any]
  #
  #   fn   Function to map over modules.
  #   dir  Directory to recursively map modules in.
  #
  # Map function fn over all nix modules or all nix files recursively in dir.
  mapModulesRec' = fn: dir:
    let
      dirs = mapAttrsToList (k: _: "${toString dir}/${k}")
        (filterAttrs (n: v: v == "directory" && !(hasPrefix "_" n))
          (readDir dir));
      files = attrValues (mapModule id dir);
      paths = files ++ concatLists (map (d: mapModulesRec' id d) dirs);
    in map fn paths;
}
