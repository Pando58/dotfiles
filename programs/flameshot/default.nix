{
  ...
}: {
  services.flameshot.enable = true;

  services.flameshot.settings.General = {
    contrastOpacity = 76;
    uiColor = "#7ec9ff";
    contrastUiColor = "#000d32";
    drawColor = "#00ff00";
    drawThickness = 2;
    filenamePattern = "%F_%H-%M-%S";
    showMagnifier = true;
    squareMagnifier = true;
    showStartupLaunchMessage = false;
    startupLaunch = false;
    autoCloseIdleDaemon = true;
  };
}
