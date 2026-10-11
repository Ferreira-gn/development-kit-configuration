{ config, pkgs, ... }:

let
  android-install = pkgs.writeShellApplication {
    name = "android-install";

    runtimeInputs = [
      pkgs.android-tools
      pkgs.gawk
    ];

    text = builtins.readFile ../scripts/android-install.sh;
  };
in
{
  home.packages = [
    android-install
  ];
 
  # Aliases da sessão para ações rápidas
  # durante o desenvolvimento de aplicações Android/Expo.

  home.shellAliases = {
    android-usb-dev =
      "adb reverse tcp:8081 tcp:8081";

    android-dev =
      "npx expo start --dev-client";

    android-devices =
      "adb devices";

    android-restart =
      "adb kill-server && adb start-server";
  };

}
