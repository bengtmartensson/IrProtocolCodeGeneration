#!/bin/sh

# Warning: This script WILL overwrite existing ir_*.cpp files!
# Be sure you know what you are doing!

# Hierarch bitspecs
#arctech \
#arctech-38 \
#entone \
#RC6 \
#RC6-6-20 \
#RC6-M-16 \
#RC6-M-28 \
#RC6-M-32 \
#RC6-M-56 \
#Replay \
#Sejin-1-38 \
#Sejin-1-56 \
#Zenith \
#Zenith5 \
#Zenith6 \
#Zenith7 \
#Zenith8

#B&O \
#B&O repeat \
#MCIR-2-kbd \
#MCIR-2-mouse \

PROTS="48-NEC1 \
48-NEC2 \
AdNotam \
Aiwa \
Aiwa2 \
Akai \
Amino \
Amino-56 \
Anthem \
Anthem_relaxed \
Apple \
Archer \
Audiovox \
Barco \
Blaupunkt \
Blaupunkt_relaxed \
Bose \
Bryston \
CanalSat \
CanalSatLD \
Canon \
Denon \
Denon-K \
Denon{1} \
Denon{2} \
Dgtec \
Digivision \
DirecTV \
DirecTV_3_FG \
Dish_Network \
Dishplayer \
Dysan \
Elan \
Emerson \
Epson \
F12 \
F12-0 \
F12-1 \
F32 \
Fujitsu \
Fujitsu-128 \
Fujitsu-56 \
Fujitsu_Aircon \
G.I.4DTV \
G.I.4DTVnoCheck \
G.I.Cable \
GI%20RG \
Grundig16 \
Grundig16-30 \
GuangZhou \
GwtS \
GXB \
Humax%204Phase \
IODATAn \
Jerrold \
JVC \
JVC-48 \
JVC-56 \
JVC{2} \
Kaseikyo \
Kaseikyo56 \
Kathrein \
Konka \
Logitech \
Lumagen \
Lutron \
Matsui \
MCE \
Metz19 \
Mitsubishi \
Mitsubishi-K \
NEC \
NEC-Shirriff \
NEC-Shirriff-32 \
NEC1 \
NEC1-f16 \
NEC1-rnc \
NEC2 \
NECx1 \
NECx2 \
Nokia \
Nokia12 \
Nokia32 \
Nova%20Pace \
NRC16 \
NRC16-32 \
NRC17 \
OrtekMCE \
PaceMSS \
Panasonic \
Panasonic2 \
Panasonic_Old \
PCTV \
pid-0001 \
pid-0003 \
pid-0004 \
pid-0083 \
Pioneer \
Pioneer-Mix \
Proton \
Proton-40 \
RC5 \
RC5-7F \
RC5-7F-57 \
RC5x \
RCA \
RCA(Old) \
RCA-38 \
RCA-38(Old) \
RECS80 \
RECS80-0045 \
RECS80-0068 \
RECS80-0090 \
Revox \
Roku \
Rs200 \
Sampo \
Samsung20 \
Samsung36 \
ScAtl-6 \
Sharp \
SharpDVD \
Sharp{1} \
Sharp{2} \
SIM2 \
Solidtek16 \
Somfy \
Sony12 \
Sony15 \
Sony20 \
Sony8 \
StreamZap \
StreamZap-57 \
Sunfire \
TDC-38 \
TDC-56 \
Teac-K \
Thomson \
Thomson7 \
Tivo \
Velleman \
Velodyne \
Viewstar \
Whynter \
X10 \
X10.n \
X10_18 \
X10_8 \
Xiaomi \
XMP \
XMP-1 \
XMP-2 \
XMPff \
XMPff-1 \
XMPff-2 \
XMPMeta \
Zaptor-36 \
Zaptor-56 \
"

for p in $PROTS ; do
    if tools/generate-irremote-protocol.sh "$p" ; then
        true;
    else
        exit 1;
    fi
done
