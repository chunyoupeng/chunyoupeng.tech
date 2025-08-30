#!/usr/bin/env bash
set -euo pipefail

# Delete year directories under content/ in a safe, confirmable way.
# Usage:
#   scripts/delete_years.sh [START_YEAR END_YEAR] [-n] [-y]
# Examples:
#   scripts/delete_years.sh            # defaults to 2009..2024
#   scripts/delete_years.sh 2012 2020  # custom range
#   scripts/delete_years.sh -n         # dry-run (show what would be deleted)
#   scripts/delete_years.sh -y         # skip confirmation

CONTENT_DIR="content"
DEFAULT_START=2009
DEFAULT_END=2024
ASSUME_YES=false
DRY_RUN=false

is_number() { [[ ${1:-} =~ ^[0-9]{4}$ ]]; }

START="$DEFAULT_START"
END="$DEFAULT_END"

ARGS=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -y|--yes)
      ASSUME_YES=true; shift ;;
    -n|--dry-run)
      DRY_RUN=true; shift ;;
    -h|--help)
      sed -n '1,40p' "$0" | sed -n '1,20p'
      exit 0 ;;
    *)
      ARGS+=("$1"); shift ;;
  esac
done

if [[ ${#ARGS[@]} -gt 0 ]]; then
  if [[ ${#ARGS[@]} -ne 2 ]] || ! is_number "${ARGS[0]}" || ! is_number "${ARGS[1]}"; then
    echo "Error: pass either no args, or START_YEAR END_YEAR (e.g. 2009 2024)." >&2
    exit 1
  fi
  START="${ARGS[0]}"
  END="${ARGS[1]}"
fi

if [[ ! -d "$CONTENT_DIR" ]]; then
  echo "Error: '$CONTENT_DIR' directory not found. Run from repo root." >&2
  exit 1
fi

if (( START > END )); then
  echo "Error: START_YEAR ($START) must be <= END_YEAR ($END)." >&2
  exit 1
fi

to_delete=()
for year in $(seq "$START" "$END"); do
  dir="$CONTENT_DIR/$year"
  if [[ -d "$dir" ]]; then
    to_delete+=("$dir")
  fi
done

if [[ ${#to_delete[@]} -eq 0 ]]; then
  echo "No year directories found to delete in $CONTENT_DIR for range $START..$END."
  exit 0
fi

echo "The following directories will be deleted (range $START..$END):"
for d in "${to_delete[@]}"; do
  echo "  $d"
done

if [[ "$DRY_RUN" == true ]]; then
  echo "Dry-run mode: no changes made."
  exit 0
fi

if [[ "$ASSUME_YES" != true ]]; then
  read -r -p "Proceed to delete these directories? [y/N] " ans
  case "${ans,,}" in
    y|yes) ;;
    *) echo "Aborted."; exit 1 ;;
  esac
fi

for d in "${to_delete[@]}"; do
  echo "Deleting $d"
  rm -rf -- "$d"
done

echo "Done. Consider running 'make content' to rebuild the site."

