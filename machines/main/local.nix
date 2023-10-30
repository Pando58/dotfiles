{
  pkgs,
  pkgs-unstable,
  username,
  ...
}: {
  fileSystems = {
    "/mnt/ExtraLinux" = {
      device = "/dev/disk/by-label/ExtraLinux";
    };
    "/mnt/SSDExtra" = {
      device = "/dev/disk/by-label/SSDExtra";
    };
    # "/mnt/DatosWindows" = {
    #   device = "/dev/disk/by-label/DatosWindows";
    # };
  };

  services.xserver.screenSection = ''
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "nvidiaXineramaInfoOrder" "DFP-5"
    Option         "metamodes" "DP-4: 2560x1440_144 +1920+400 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On, AllowGSYNCCompatible=On}, HDMI-0: 1920x1080_60 +4480+0 {rotation=left, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-1: 1920x1080_60 +0+540 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
    EndSubSection
  '';

  home-manager.users.${username} = {
    home.packages = (with pkgs; [
      progress
      brave
      protontricks
      legendary-gl
      heroic
      g810-led
      nodejs
      nodePackages.eslint_d
      gcc
    ]) ++ (with pkgs-unstable; [
      yuzu-mainline
      discord
      obsidian
      reaper
      qpwgraph
      yabridge
      yabridgectl
      inkscape
      blender
    ]);
  };

  programs.steam.enable = true;

  # services.flatpak.enable = true;
  # xdg.portal.enable = true; # required for flatpak
  #
  # xdg.portal.extraPortals = [
  #   pkgs.xdg-desktop-portal
  #   pkgs.xdg-desktop-portal-gtk
  # ];

  programs.git = {
    config = {
      user.email = "enr.pando@gmail.com";
      user.name = "Enrique pando";
    };
  };

  systemd.user.services.g810led = {
    script = ''
      g810-led -p /etc/g810-led/profile
    '';
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };
}
