#!/bin/bash

DOWNLOAD_DIR="$HOME/Downloads"
IMAGE_DIR="$HOME/Pictures"
VIDEO_DIR="$HOME/Videos"
DOC_DIR="$HOME/Documents"
MUSIC_DIR="$HOME/Music"
APP_DIR="$HOME/apps"
OTHER_DIR="$HOME/others"

# Create directories if they don't exist
mkdir -p "$IMAGE_DIR" "$VIDEO_DIR" "$DOC_DIR" "$MUSIC_DIR" "$DEB_DIR" "$RPM_DIR" "$OTHER_DIR"

# Function to move file with incrementing suffix if file exists
move_file() {
    local src_file="$1"
    local dest_dir="$2"
    local base_name=$(basename "$src_file")
    local dest_file="$dest_dir/$base_name"
    local count=1

    while [ -e "$dest_file" ]; then
        dest_file="$dest_dir/${base_name%.*}_$count.${base_name##*.}"
        ((count++))
    done

    mv "$src_file" "$dest_file"
}

# Move files to respective directories
for file in "$DOWNLOAD_DIR"/*; do
    if [ -f "$file" ]; then
        case "${file,,}" in
            *.jpg|*.jpeg|*.png|*.gif|*.bmp|*.tiff)
                move_file "$file" "$IMAGE_DIR"
                ;;
            *.mp4|*.mkv|*.flv|*.avi|*.mov|*.wmv)
                move_file "$file" "$VIDEO_DIR"
                ;;
            *.pdf|*.doc|*.docx|*.xls|*.xlsx|*.ppt|*.pptx|*.txt)
                move_file "$file" "$DOC_DIR"
                ;;
            *.mp3|*.wav|*.flac|*.aac|*.ogg)
                move_file "$file" "$MUSIC_DIR"
                ;;
            *.deb|*.rpm)
                move_file "$file" "$APP_DIR"
                ;;
            )
                move_file "$file" "$OTHER_DIR"
                ;;
        esac
    fi
done

echo "Download folder organized successfully."