#!/bin/bash
steam_path="$HOME/.local/share/Steam"
proton_base_path="$steam_path/steamapps/common/Proton - Experimental"
proton_path="$proton_base_path/proton"
pressure_vessel_base_path="$steam_path/steamapps/common/SteamLinuxRuntime_sniper"
pressure_vessel_path="$pressure_vessel_base_path/pressure-vessel"
sniper_version="sniper_platform_3.0.20250108.112707"

if [ -z "$WINEPREFIX" ]
then
    echo "No WINEPREFIX?" 
    exit 1
else
    mkdir -p "$WINEPREFIX"
fi


if [ "$1" == "" ]
then
    echo "Usage: $0 <EXECUTABLE>"
    exit 1
fi

exe_path=$(readlink -f "$1")
exe_base_path=$(dirname "$exe_path")

export PROTON_CRASH_REPORT_DIR=/tmp/proton_standalone_crashreports
export STEAM_COMPAT_APP_ID=0
export STEAM_COMPAT_TOOL_PATHS="$proton_base_path:$pressure_vessel_base_path"
export STEAM_COMPAT_LIBRARY_PATHS=/home
export STEAM_COMPAT_MOUNTS="$steam_path/steamapps/common/Steamworks Shared:$proton_base_path:$pressure_vessel_base_path"
export STEAM_COMPAT_DATA_PATH="$WINEPREFIX"
export STEAM_COMPAT_SHADER_PATH="$WINEPREFIX/shadercache"
export STEAM_RUNTIME_LIBRARY_PATH=$steam_path/ubuntu12_32/steam-runtime/pinned_libs_32:$steam_path/ubuntu12_32/steam-runtime/pinned_libs_64:/usr/lib/x86_64-linux-gnu/fakechroot:/usr/lib/x86_64-linux-gnu/libfakeroot:/lib/i386-linux-gnu:/usr/local/lib:/usr/local/lib/x86_64-linux-gnu:/lib/x86_64-linux-gnu:/lib32:/libx32:/lib:$steam_path/ubuntu12_32/steam-runtime/lib/i386-linux-gnu:$steam_path/ubuntu12_32/steam-runtime/usr/lib/i386-linux-gnu:$steam_path/ubuntu12_32/steam-runtime/lib/x86_64-linux-gnu:$steam_path/ubuntu12_32/steam-runtime/usr/lib/x86_64-linux-gnu:$steam_path/ubuntu12_32/steam-runtime/lib:$steam_path/ubuntu12_32/steam-runtime/usr/lib
export STEAM_COMPAT_CLIENT_INSTALL_PATH=
export STEAM_COMPAT_INSTALL_PATH="$exe_base_path"
export SteamAppId=0
export SteamGameId=0

export PRESSURE_VESSEL_COPY_RUNTIME=1
export PRESSURE_VESSEL_RUNTIME="$sniper_version"
export PRESSURE_VESSEL_RUNTIME_BASE="$pressure_vessel_base_path"

if [ -z "${PRESSURE_VESSEL_VARIABLE_DIR-}" ] 
then
    export PRESSURE_VESSEL_VARIABLE_DIR="$pressure_vessel_base_path/var"
fi

exec "${pressure_vessel_path}/bin/pressure-vessel-unruntime" "$proton_path" "waitforexitandrun" "$exe_path"
