{ lib, ... }:

let inherit (lib) mkOption types;
in rec {
  # mkOpt :: type -> Any -> AttrSet
  #
  #   type     A type.
  #   default  The default option value.
  #
  # Shorthand for mkOption of a simple default value option.
  mkOpt = type: default: mkOption { inherit type default; };

  # mkOpt' :: type -> Any -> str -> AttrSet
  #
  #   type         A type.
  #   default      The default option value.
  #   description  A description of the option.
  #
  # Shorthand for mkOption of a simple default value option with a description.
  mkOpt' = type: default: description:
    mkOption { inherit type default description; };

  # mkBoolOpt :: bool -> AttrSet
  #
  #   default  The default option value.
  #
  # Make a boolean option with a default value.
  mkBoolOpt = default:
    mkOption {
      inherit default;
      type = types.bool;
      example = true;
    };
}
