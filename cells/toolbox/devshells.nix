{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.std) std;
  l = nixpkgs.lib // builtins;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "Grease DevOps Shell";
      nixago = [
        # off-the-shelve from `std`
        (std.nixago.conform {configData = {inherit (inputs) cells;};})
        std.nixago.lefthook
        std.nixago.adrgen
        # modified from the local Cell
        cell.nixago.treefmt
        cell.nixago.editorconfig
        cell.nixago.mdbook
      ];
      commands = [
        {
          package = nixpkgs.reuse;
          category = "legal";
        }
      ];
      imports = [std.devshellProfiles.default];
    };
  }
