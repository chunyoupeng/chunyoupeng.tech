#!/usr/bin/env bash
set -euo pipefail

SRC="${1:-static/about/chunyoupeng.png}"
OUT_DIR="static/about"

if [[ ! -f "$SRC" ]]; then
  echo "Source image not found: $SRC" >&2
  exit 1
fi

if ! command -v magick >/dev/null 2>&1; then
  echo "ImageMagick 'magick' binary is required but not found in PATH." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

# Center-crop to a square then resize to keep icons consistent.
resize_square() {
  local size="$1"
  local dest="$2"
  local quality="${3:-92}"

  magick "$SRC" \
    -resize "${size}x${size}^" \
    -gravity center \
    -extent "${size}x${size}" \
    -strip \
    -quality "$quality" \
    "$dest"
}

# Avatar for the about page and footer (2x retina size).
resize_square 320 "$OUT_DIR/chunyoupeng-2x.jpg" 90
magick "$OUT_DIR/chunyoupeng-2x.jpg" -strip -quality 85 "$OUT_DIR/chunyoupeng-2x.avif"

# Open Graph/Twitter card (16:9 crop).
magick "$SRC" \
  -resize "1300x1300^" \
  -gravity center \
  -extent 1200x630 \
  -strip \
  -quality 90 \
  "$OUT_DIR/chunyoupeng-og.jpg"

# App/favicons.
resize_square 512 "$OUT_DIR/android-chrome-512x512.png"
resize_square 192 "$OUT_DIR/android-chrome-192x192.png"
resize_square 180 "$OUT_DIR/apple-touch-icon.png"
resize_square 32 "$OUT_DIR/favicon-32x32.png"
resize_square 16 "$OUT_DIR/favicon-16x16.png"

# Multi-size ICO bundle.
tmp_icon="$(mktemp)"
trap 'rm -f "$tmp_icon"' EXIT
resize_square 256 "$tmp_icon"
magick "$tmp_icon" -define icon:auto-resize=16,32,48 "$OUT_DIR/favicon.ico"
