#!/bin/bash

set -e

BASE_DIR="base"
VARIANTS_DIR="variants"
THEMES_DIR="themes"
RELEASES_DIR="releases"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Validate directories
[ ! -d "$BASE_DIR" ] && echo -e "${RED}Error: Base directory not found!${NC}" && exit 1
[ ! -d "$VARIANTS_DIR" ] && echo -e "${RED}Error: Variants directory not found!${NC}" && exit 1

mkdir -p "$THEMES_DIR" "$RELEASES_DIR"

# Get variant images
variant_images=$(find "$VARIANTS_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

if [ -z "$variant_images" ]; then
    rm -rf "$THEMES_DIR"/* "$RELEASES_DIR"/* 2>/dev/null || true
    exit 0
fi

# Process variants
declare -a current_variant_names

for variant_path in $variant_images; do
    variant_filename=$(basename "$variant_path")
    variant_name="${variant_filename%.*}"
    current_variant_names+=("$variant_name")
    
    theme_dir="$THEMES_DIR/$variant_name"
    mkdir -p "$theme_dir"
    
    cp -r "$BASE_DIR"/* "$theme_dir/"
    cp "$variant_path" "$theme_dir/"
    sed -i "s|desktop-image: \".*\"|desktop-image: \"$variant_filename\"|" "$theme_dir/theme.txt"
done

# Create zip files
cd "$THEMES_DIR"
for variant_name in "${current_variant_names[@]}"; do
    [ -d "$variant_name" ] && zip -r "../$RELEASES_DIR/${variant_name}.zip" "$variant_name" -q
done
cd - > /dev/null

# Cleanup orphaned themes
for theme_dir in "$THEMES_DIR"/*; do
    [ -d "$theme_dir" ] || continue
    theme_name=$(basename "$theme_dir")
    found=false
    for variant_name in "${current_variant_names[@]}"; do
        [ "$theme_name" = "$variant_name" ] && found=true && break
    done
    [ "$found" = false ] && rm -rf "$theme_dir"
done

echo -e "${GREEN}Generated ${#current_variant_names[@]} theme(s)${NC}"
