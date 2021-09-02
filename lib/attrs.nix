{ lib, ... }:

let
  inherit (lib.attrsets) mapAttrs' mapAttrsToList filterAttrs;
  inherit (lib.lists) any count;
in rec {
  # attrsToList :: AttrSet -> [ {name=name, value=value} ... ]
  #
  #   attrs  The attrset to be flattened.
  #
  # Flattens an attrset to a list of nv-pair attrsets.
  attrsToList = attrs:
    mapAttrsToList (name: value: { inherit name value; }) attrs;

  # mapFilterAttrs :: (String -> Any -> { name=String; value=Any; })
  #                -> (name -> value -> bool)
  #                -> AttrSet
  #                -> AttrSet
  #
  #   f      Function to map.
  #   pred   Predicate used to filter.
  #   attrs  Attrset on which to map and filter.
  #
  # Map f over attrs and filters the resulting AttrSet based on pred.
  mapFilterAttrs = f: pred: attrs: filterAttrs pred (mapAttrs' f attrs);

  # anyAttrs :: (name -> value -> bool) -> AttrSet -> bool
  #
  #   pred   Predicate to fulfill.
  #   attrs  Attrset to look in.
  #
  # Any attr fulfill pred?
  anyAttrs = pred: attrs:
    any (attr: pred attr.name attr.value) (attrsToList attrs);

  # countAttrsIf :: (name -> value -> bool) -> AttrSet -> int
  #
  #   pred   Predicate to check.
  #   attrs  Attrset to count in.
  #
  # Count num attrs fulfilling pred.
  countAttrsIf = pred: attrs:
    count (attr: pred attr.name attr.value) (attrsToList attrs);
}
