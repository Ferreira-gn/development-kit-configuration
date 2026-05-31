{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi
  ];

  xdg.configFile."rofi".source = ../rofi;
  
  # font : https://github.com/adi1090x/rofi
}
