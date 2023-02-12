{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in {
  grease = nixpkgs.mkDerivation rec {
    pname = "grease";
    version = "0.3.0";
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
        --subst-var-by deps "${l.makeBinPath buildInputs}"
    '';
  };
}
