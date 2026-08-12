{ config, lib, pkgs, ... }:

let
  androidComposition =
    pkgs.androidenv.composeAndroidPackages {
      platformVersions = [
        "35"
      ];

      buildToolsVersions = [
        "35.0.0"
      ];

      platformToolsVersion = "35.0.2";

      includeEmulator = false;
      includeSystemImages = false;
      includeSources = false;

      includeNDK = false;
      ndkVersions = [];

      cmakeVersions = [];
    };

  androidSdk = androidComposition.androidsdk;

in
{
  environment.systemPackages = [
    androidSdk
    pkgs.android-tools
  ];

  programs.adb.enable = true;

  environment.variables = {
    ANDROID_HOME =
      "${androidSdk}/libexec/android-sdk";

    ANDROID_SDK_ROOT =
      "${androidSdk}/libexec/android-sdk";
  };

  nixpkgs.config = {
    android_sdk.accept_license = true;
  };
}
