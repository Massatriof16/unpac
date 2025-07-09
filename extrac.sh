#!/bin/bash

# Set the title (not applicable in bash)
# title Unpacker_PAC
chmod a+x *
currentdir=$(pwd)
file="$HOME/storage/downloads"
folderextract="$HOME/storage/downloads/extract"
mkdir -p $folderextract
# Create the extract folder if it doesn't exist


menu() {
    clear
    echo "============================"
    echo "          UNPACK PAC       "
    echo "============================"
    echo "[1]. Ekstrak Semua file dari .pac"
    echo "[2]. Unpack salah satu File dari .pac"
    echo "[3]. Exit"
    read -p "PILIH 1/2: " pilih

    case "$pilih" in
        1) all ;;
        2) some ;;
        3) exit 0 ;;
        *) echo "Pilihan anda Tidak Valid"; menu ;;
    esac
}

all() {
    clear
    echo "======================================="
    echo "        EKSTRAK SEMUA ISI FILE PAC   "
    echo "======================================="

    if ! ls "$file"/*.pac 1> /dev/null 2>&1; then
        echo "File .pac tidak ditemukan. Letakkan file .pac di folder \"$file\""
        read -p "Press any key to continue..." -n1 -s
        menu
    else
        echo "File ditemukan."
        for f in "$file"/*.pac; do
            if [[ -e "$f" ]]; then
                fileName=$(basename "$f" .pac)
            fi
        done
        echo "Mengekstrak file: $fileName.pac ..."
       "$currentdir/unpac" -d "$folderextract" extract "$file/$fileName.pac"
        echo "Ekstraksi selesai. Semua file telah diekstrak ke folder \"$folderextract\""
    fi

    read -p "Press any key to continue..." -n1 -s
    menu
}

some() {
    clear
    echo "======================================="
    echo "        EKSTRAK 1 FILE DALAM PAC     "
    echo "======================================="

    if ! ls "$file"/*.pac 1> /dev/null 2>&1; then
        echo "File .pac tidak ditemukan. Letakkan file .pac di folder \"$file\""
        read -p "Press any key to continue..." -n1 -s
        menu
    else
        echo "File ditemukan."
        for f in "$file"/*.pac; do
            if [[ -e "$f" ]]; then
                fileName=$(basename "$f" .pac)
            fi
        done

        echo "=============================================="
        "$currentdir/unpac" list "$file/$fileName.pac"
      
          echo "=============================================="
        echo "petunjuk: - KETIK ID ATAU NAMA FILE yang muncul di list atas untuk Ekstrak 1 file saja yang ada di dalam pac (PASTIKAN SESUAI DENGAN INFORMASI YANG ADA DI ATAS)"
        read -p "Ketik Sesuai Petunjuk: " ekstrak
        if [[ -z "$ekstrak" ]]; then
            echo "Tidak ada file yang dipilih untuk diekstrak."
            read -p "Press any key to continue..." -n1 -s
            menu
        fi
       exec  "$currentdir/unpac" -d "$folderextract" extract "$file/$fileName.pac" "$ekstrak"
        echo "Ekstraksi $ekstrak berhasil. File telah diekstrak ke folder \"$folderextract\""
    fi

     read -p "Press any key to continue..." -n1 -s
     menu
}

menu