{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = with pkgs; [
    deadnix
    findutils
    git
    gnumake
    gnused
    nixfmt
    statix
  ];

  shellHook = ''
    echo "Nix shell development environment ready!"
    echo
    echo "  make fmt    Format Nix files"
    echo "  make check  Run all checks"
  '';
}
