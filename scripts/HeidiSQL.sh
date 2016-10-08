#!/usr/bin/env bash
wget http://www.heidisql.com/downloads/releases/HeidiSQL_9.3_Portable.zip -O HeidiSQL.zip
mkdir -p /opt/HeidiSQL
unzip HeidiSQL.zip -d /opt/HeidiSQL
chmod +x /opt/HeidiSQL/heidisql.exe

touch /usr/share/applications/HeidiSQL.desktop

cat <<EOF > /usr/share/applications/HeidiSQL.desktop
[Desktop Entry]
Name=HeidiSQL
Exec=wine /opt/HeidiSQL/heidisql.exe
Icon=HeidiSQL
Type=Application
Categories=GTK;GNOME;Utility;
EOF

ln -s /opt/HeidiSQL/heidisql.exe /bin/HeidiSQL

wrestool -x -n MAINICON /opt/HeidiSQL/heidisql.exe > /opt/HeidiSQL/HeidiSQL.ico
convert /opt/HeidiSQL/HeidiSQL.ico\[0\] /usr/share/icons/HeidiSQL.png

rm HeidiSQL.zip -f
