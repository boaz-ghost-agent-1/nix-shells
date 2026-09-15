{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    neovim
    jq
    git
    fastfetch
    lolcat
  ];
  shellHook = ''
    echo "CORE development shell ready!"
  '';
}
