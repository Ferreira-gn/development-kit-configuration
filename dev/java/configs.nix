{ pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    (maven.override { jdk_headless = pkgs.javaPackages.compiler.openjdk25; })
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.javaPackages.compiler.openjdk25}";
  };
}
