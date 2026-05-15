{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ################################################################################
  # Boot / Sistema Base
  ################################################################################

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Fortaleza";

  i18n.defaultLocale = "pt_BR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  hardware.enableAllFirmware = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  ################################################################################
  # Gráficos / GPU (Intel Tiger Lake)
  ################################################################################

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver    # VAAPI iHD
      intel-vaapi-driver    # fallback i965
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  ################################################################################
  # Display Manager e Ambientes Gráficos
  ################################################################################

  # X11/Wayland base (necessário para GDM)
  services.xserver.enable = true;

  # Display Manager (ponto de convergência)
  services.displayManager.gdm.enable = true;

  # GNOME — ambiente fallback para usuários comuns
  services.desktopManager.gnome.enable = true;

  # serviço de keyring do sistema (Secret Service)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.sudo.enableGnomeKeyring = true;

  # Hyprland — ambiente de desenvolvimento
  programs.hyprland.enable = true;

 
  # COSMIC - ambiente de testes
  services.desktopManager.cosmic.enable = true;
  services.system76-scheduler.enable = true;
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  ################################################################################
  # Portals 
  ################################################################################

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  ################################################################################
  # Input / Energia
  ################################################################################

  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = true;

  services.power-profiles-daemon.enable = true;

  ################################################################################
  # Áudio
  ################################################################################

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;
  };


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  services.pipewire.extraConfig.pipewire."10-bluez" = {
    "context.properties" = {
      "bluez5.enable" = true;
      "bluez5.roles" = [
        "a2dp_sink"
        "a2dp_source"
        "hfp_hf"
      ];
      "bluez5.enable-hw-volume" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-sbc-xq" = true;
    };
  };



  ################################################################################
  # Impressão / Flatpak
  ################################################################################

  services.printing.enable = true;
  services.flatpak.enable = true;

  ################################################################################
  # Usuários
  ################################################################################

  users.users.ferreira-gn = {
    isNormalUser = true;
    description = "ferreira-gn";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };

  programs.zsh.enable = true;

  environment.etc."ssh/ssh_config".text = ''
    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/id_ed25519
      IdentitiesOnly yes

    Host gitlab.com
      HostName gitlab.com
      User git
      IdentityFile ~/.ssh/id_ed25519
      IdentitiesOnly yes
  '';

  ################################################################################
  # Virtualização
  ################################################################################

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  ################################################################################
  # Pacotes do Sistema
  ################################################################################

  environment.systemPackages = with pkgs; [

    # Utilitários gráficos / audio
    mesa-demos
    libva-utils
    vulkan-tools
    intel-gpu-tools
    gparted

    pulseaudio
    wireplumber
    pipewire
    pavucontrol
    bluez
    blueman
    pulseaudio


    # GNOME (fallback)
    gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.vitals
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tiling-shell
    sushi
    libsecret # keyring do sistema

    # Hyprland / Wayland
    hyprland
    waybar
    wofi
    rofi
    hyprpaper
    hypridle
    hyprlock
    playerctl
    polkit

    # Apps
    obsidian
    obs-studio
    flameshot
    (brave.override {
      commandLineArgs = [
        "--enable-features=VaapiVideoDecoder,UseOzonePlatform"
        "--ozone-platform=wayland"
        "--ignore-gpu-blocklist"
      ];
    })


    # Games
    steam
    heroic

    # Dev
    git
    gcc
    go
    nodejs_24

    python312
    poetry

    javaPackages.compiler.openjdk21
    kotlin                     
    gradle                     
    maven                      


    # Dev tools
    vscode
    zed-editor
    android-studio
    jetbrains.idea-oss 
    insomnia
    kitty
    alacritty
    qtscrcpy

    # Shell
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    fd
    bat
    eza
    zsh-prezto
    pure-prompt

  ];

  # LSP 
  programs.nix-ld.enable = true;

  ################################################################################
  # Estado do Sistema
  ################################################################################

  system.stateVersion = "25.11";
}
