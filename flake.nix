{
  description = "A standardized flake for an oily nix";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.std.inputs.nixpkgs.follows = "nixpkgs";
  inputs.std.url = "github:divnix/std";

  outputs = {
    std,
    self,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./cells;
      cellBlocks = with std.blockTypes; [
        (installables "packages")
        (devshells "devshells")
        (functions "profiles")
        (functions "modules")
        (nixago "nixago")
      ];
    }
    {
      devShells = std.harvest inputs.self ["toolbox" "devshells"];
      packages = std.harvest inputs.self [
        ["oil-shell" "packages"]
        ["grease" "packages"]
        # ["faux-bash" "packages"]
      ];
      nixosModules = std.harvest inputs.self [
        ["oil-shell" "modules"]
        # ["faux-bash" "profiles"]
      ];
    };
}
