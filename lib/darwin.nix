{ ... }:

{
  hotkeys = {
    spotlight = 64;
  };

  disableHotkeys = let
    systemAdministration = "/System/Library/PrivateFrameworks/SystemAdministration.framework";

    disableHotkey = k: ''
      defaults write \
        com.apple.symbolichotkeys.plist AppleSymbolicHotKeys \
        -dict-add ${toString k} '<dict><key>enabled</key><false/></dict>'
    '';
  in ks: ''
    echo >&2 "disabling default hotkeys..."
    ${builtins.concatStringsSep "\n" (map disableHotkey ks)}
    ${systemAdministration}/Resources/activateSettings -u
  '';

  enableBatteryWakeOnLan = isEnabled: ''
    echo >&2 "setting Wake-on-LAN..."
    pmset -b womp ${if isEnabled then "1"else "0"}
  '';
}
