{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    go
    gopls
    golangci-lint

    # Packages for grpc request in Golang
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    # Hot reload tool for golang
    air
  ];
}
