{ pkgs, ... }:

let
  qt = pkgs.qt6;
in
{
  home.packages = with pkgs; [
    quickshell
    
    jq
    qt.qtbase
    qt.qtdeclarative
    qt.qtwayland
    qt.qttools
    qt.qtsvg
    qt.qtimageformats
    qt.qtwayland

    material-symbols
    
    qt.qtmultimedia
    qt.qtshadertools
    kdePackages.layer-shell-qt
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    QML_IMPORT_PATH = "${qt.qtdeclarative}/lib/qt-6/qml:" + "${pkgs.quickshell}/lib/qt-6/qml";

    QML2_IMPORT_PATH = "${qt.qtdeclarative}/lib/qt-6/qml:" + "${pkgs.quickshell}/lib/qt-6/qml";
  };
}
