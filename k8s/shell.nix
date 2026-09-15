{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    docker
    k3d
    docker-compose
    kubectl

  ];
  shellHook = ''
    export DOCKER_HOST="unix:///var/run/docker.sock"
  '';
}
