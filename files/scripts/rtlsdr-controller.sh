#!/bin/sh

#for rtl-sdr reception in ghpsdr3-alex / QtRadio
no() {
gnome-terminal -e 'rtlsdr-server -d3 -s1024000' &
sleep 2
gnome-terminal -e 'dspserver --lo 9000' &
sleep 2
QtRadio 127.0.0.1
killall rtlsdr-server
killall dspserver
}

yes() {
gnome-terminal -e 'rtlsdr-server -d3 -s1024000' &
sleep 2
gnome-terminal -e 'dspserver --lo 9000' &
sleep 2
QtRadio 127.0.0.1
killall rtlsdr-server
killall dspserver
}

echo ""
read -p "Create keys for this session? (Y,n) " choice1
case "$choice1" in 
  y|Y ) 
  openssl genrsa -out pkey 2048
  openssl req -new -key pkey -out cert.req
  openssl x509 -req -days 365 -in cert.req -signkey pkey -out cert
  yes
  echo ""
  echo ""
;;
  n|N )
  no
  echo ""
  echo ""
;;
esac

