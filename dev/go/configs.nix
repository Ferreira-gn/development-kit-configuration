{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [

    # Packages for grpc request in Golang
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    # Hot reload tool for golang
    air

  ];
}
