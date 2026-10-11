#!/usr/bin/env bash

set -euo pipefail

usage() {
    echo "Uso: android-install <apk> [serial]"
    exit 1
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
    usage
fi

apk="$1"

if [[ ! -f "$apk" ]]; then
    echo "Erro: APK não encontrado: $apk"
    exit 1
fi

if [[ $# -eq 2 ]]; then
    serial="$2"

    echo "Instalando $apk no dispositivo $serial..."

    exec adb -s "$serial" install -r "$apk"
fi

mapfile -t devices < <(
    adb devices |
        awk '$2 == "device" { print $1 }'
)

device_count="${#devices[@]}"

if [[ "$device_count" -eq 0 ]]; then
    echo "Erro: nenhum dispositivo Android conectado."
    exit 1
fi

if [[ "$device_count" -gt 1 ]]; then
    echo "Erro: múltiplos dispositivos conectados."
    echo
    echo "Dispositivos disponíveis:"
    adb devices
    echo
    echo "Use:"
    echo "  android-install $apk <serial>"
    exit 1
fi

serial="${devices[0]}"

echo "Instalando $apk no dispositivo $serial..."

exec adb -s "$serial" install -r "$apk"
