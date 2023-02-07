{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in {
  grease = nixpkgs.mkDerivation {
    pname = "grease";
    version = "proto-v1";
    src = ./library.oil;
    buildInputs = with nixpkgs; [
      inputs.cells.oil-shell.packages.oil
      ripgrep
      numfmt
      jq
      jo
      bc
    ];
    installPhase = ''
      substitute $src $out \
        --subst-var-by runtimeInputs "${lib.makeBinPath buildInputs}"
    '';
  };
}
