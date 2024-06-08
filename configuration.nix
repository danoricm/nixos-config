{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sdb";
    useOSProber = true;
    configurationLimit = 15;
  };

  # Define your hostname.
  networking.hostName = "dddyo";

  # Enable NetworkManager.
  networking.networkmanager.enable = true;

  # Optimize networking settings
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  console.keyMap = "us";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable all window manager options
  services.xserver.windowManager = {
    awesome.enable = true;
    berry.enable = true;
    bspwm = {
      enable = true;
      sxhkd.package = pkgs.sxhkd;
    };
    cwm.enable = true;
    dwm.enable = true;
    exwm.enable = true;
    fluxbox.enable = true;
    herbstluftwm.enable = true;
    hypr.enable = true;
    i3.enable = true;
    icewm.enable = true;
    leftwm.enable = true;
    openbox.enable = true;
    qtile.enable = true;
    spectrwm.enable = true;
    stumpwm.enable = true;
    tinywm.enable = true;
    xmonad.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Enable SDDM display manager
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "none+bspwm";

  # SDDM settings
  services.displayManager.sddm.theme = "breeze";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with PipeWire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # No touchpad support
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dddyo = {
    isNormalUser = true;
    description = "dddyo";
    extraGroups = [ "networkmanager" "wheel" "libvirt" "docker" "podman" ];
    packages = with pkgs; [ kate firefox tree ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim wget

    # Status bars and terminals
    alacritty st xterm rxvt_unicode dzen2 polybar lemonbar xmobar tint2 bumblebee-status i3status

    # Git tools
    git gitAndTools.github-desktop

    # Container tools
    podman podman-compose podman-desktop buildah skopeo crun fuse-overlayfs docker docker-compose docker-credential-helpers cri-o kubernetes kubernetes-helm kubectl minikube

    # Browsers
    librewolf vimb surf tabbed

    # Editors and IDEs
    vscode emacs neovim

    # Flatpak and AppImages support
    flatpak appimage-run appimagekit libappimage

    # Program launchers
    rofi dmenu

    # System information
    neofetch

    # Office suites
    libreoffice

    # Gaming and Emulation
    steam lutris wine winePackages.staging winePackages.full winetricks q4wine dxvk protontricks

    # Virtualization tools
    libvirt qemu virt-manager

    # Alternative package managers
    apx

    # Multimedia and Graphics Tools
    obs-studio audacity gimp kdenlive krita darktable inkscape blender

    # Programming languages and support tools
    python3 python3Packages.virtualenv ruby nodejs nodePackages.npm go rustc cargo openjdk maven gradle gcc gdb clang cmake gnumake autoconf automake

    # Pen testing tools
    nmap wireshark aircrack-ng metasploit john sqlmap burpsuite nikto hashcat ettercap netcat
  ];

  # Enable Polkit and the polkit agent
  services.polkit.enable = true;
  services.lxqt-policykit.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  # Disable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
    allowedUDPPorts = [ ];
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05";
}
