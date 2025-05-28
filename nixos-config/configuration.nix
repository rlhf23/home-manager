# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./kanata.nix
    ./env.nix
  ];
  boot.loader = {
    # Bootloader.
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 4;
    efi.canTouchEfiVariables = true;
  };
  networking = {
    hostName = "os"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
    wireguard.enable = true;

    # for wireguard
    firewall.checkReversePath = false;
  };

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

  nix.settings.experimental-features = ["nix-command" "flakes"];
  security.polkit.enable = true;
  services = {
    #programs.hyprland.withUWSM  = true; #test
    displayManager.ly.enable = true;

    # usb automount
    gvfs.enable = true;
    udisks2.enable = true;
    devmon.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    # enables support for Bluetooth
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    udev.extraRules = ''
      # General ACM device rule
      KERNEL=="ttyACM[0-9]*", TAG+="uaccess", GROUP="dialout", MODE="0666"
    '';

    udev.packages = with pkgs; [platformio-core.udev];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # upower
    upower.enable = true;

    # tailscale
    tailscale.enable = true;

    # syncthing
    syncthing = {
      enable = true;
      user = "nix";
      dataDir = "/home/nix/sync";
      configDir = "/home/nix/sync/.config/syncthing";
    };
  };

  hardware.bluetooth.enable = true; # tray icon for Bluetooth

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  users = {
    # Ensure the plugdev group exists
    groups.plugdev = {};

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.nix = {
      isNormalUser = true;
      description = "nix";
      extraGroups = ["networkmanager" "wheel" "plugdev" "libvirtd"];
      shell = pkgs.nushell;
    };
    users.other = {
      isNormalUser = true;
      description = "other";
    };
  };

  # Define editor just in case
  environment.variables.EDITOR = "vim";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    helix
    kitty
    home-manager
    lxqt.lxqt-policykit

    nix-output-monitor
    nvd

    virtiofsd # virtualisation
  ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs = {
    # Enable the KDE Plasma Desktop Environment.
    # services.displayManager.sddm.enable = true;
    # services.desktopManager.plasma6.enable = true;

    # enable Hyprland
    hyprland.enable = true;

    # virtualisation
    virt-manager.enable = true;

    ## NH
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 4";
      flake = "/etc/nixos";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
