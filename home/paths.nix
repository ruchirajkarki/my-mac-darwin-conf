{ lib, config, ... }:

let
  # Define standard paths, could be made configurable if needed
  homeDirectory = config.home.homeDirectory;
  javaHome = "/opt/homebrew/opt/openjdk@21";
  androidSdkHome = "${homeDirectory}/Library/Android/sdk";
in
{
  home = {
    sessionPath = [
      "${javaHome}/bin"
      "${androidSdkHome}/platform-tools"
      "${androidSdkHome}/tools/bin"
      "${androidSdkHome}/emulator"
    ];

    sessionVariables = {
      # Java
      CPPFLAGS = "-I${javaHome}/include";

      # Android SDK
      ANDROID_HOME = androidSdkHome;
    };
  };
}
