{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellApplication {
  name = "toggle-gnome-theme";
  
  # Voeg de pakketten toe die nodig zijn voor gsettings en notify-send[cite: 1]
  runtimeInputs = [ 
    pkgs.glib 
    pkgs.libnotify 
  ];

  text = ''
    path="org.gnome.desktop.interface"
    key="color-scheme"
    current=$(gsettings get "$path" "$key")

    if [ "$current" == "'default'" ]; then
      gsettings set "$path" "$key" 'prefer-dark'
      notify-send "Theme" "Switched to dark theme"
    else
      gsettings set "$path" "$key" 'default'
      notify-send "Theme" "Switched to light theme"
    fi
  '';
}