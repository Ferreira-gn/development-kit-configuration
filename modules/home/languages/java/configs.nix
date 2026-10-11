{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Language and LSP
    javaPackages.compiler.openjdk21
    jdt-language-server
    kotlin

    # Management package
    gradle
    maven

    (maven.override { jdk_headless = pkgs.javaPackages.compiler.openjdk21; })
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.javaPackages.compiler.openjdk21}";
  };
}
