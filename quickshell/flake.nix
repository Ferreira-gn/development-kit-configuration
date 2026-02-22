{
  description = "Quickshell dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        quickshell

        qt6.qtbase
        qt6.qtdeclarative
        qt6.qtwayland
        qt6.qttools
        qt6.qtsvg
        qt6.qtimageformats
        wayland
        wayland-protocols
      ];

      shellHook = ''
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export QML2_IMPORT_PATH=${pkgs.quickshell}/lib/qt-6/qml
        echo "QML2_IMPORT_PATH=$QML2_IMPORT_PATH"
        echo "Qt / Quickshell dev shell ativo"
      '';
    };
  };
}
