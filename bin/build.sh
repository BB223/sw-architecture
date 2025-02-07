#!/usr/bin/env bash

set -e  # Exit on any error

# Default values
BUILD_DIR=""
VERBOSE=0

# Function to print messages
info() {
    echo "[INFO] $1"
}

# Function to print debug messages (only if -v is enabled)
debug() {
    if [[ "$VERBOSE" -eq 1 ]]; then
        echo "[DEBUG] $1"
    fi
}

# Function to print errors and exit
error_exit() {
    echo "[ERROR] $1" >&2
    exit 1
}

# Display usage information
usage() {
    cat <<EOF
Usage: $0 [-o <output_dir>] [-v] <input_file>

Options:
  -o <output_dir>   Specify an output directory (default: ./build)
  -v                Enable verbose mode
  -h, --help        Show this help message and exit
EOF
    exit 0
}

# Ensure required dependencies are installed
check_dependencies() {
    local missing=()
    for cmd in asciidoctor pandoc asciidoctor-pdf; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done

    if [[ ${#missing[@]} -ne 0 ]]; then
        error_exit "Missing dependencies: ${missing[*]}. Please install them first."
    fi
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -o) BUILD_DIR="$2"; shift 2 ;;
        -v) VERBOSE=1; shift ;;
        -h|--help) usage ;;
        -*) error_exit "Unknown option: $1" ;;
        *) INPUT_FILE="$1"; shift ;;
    esac
done

# Ensure input file is provided
[[ -z "$INPUT_FILE" ]] && usage

# Ensure dependencies are installed
check_dependencies

# Resolve absolute path
ABS_PATH="$(realpath "$INPUT_FILE")"
FILENAME="${ABS_PATH##*/}"
BASENAME="${FILENAME%.*}"

# Set default output directory if not specified
: "${BUILD_DIR:=$PWD/build}"

# Ensure the build directory exists
mkdir -p "$BUILD_DIR"
info "Output directory: $BUILD_DIR"

# Define output paths
DOCX_OUTPUT="$BUILD_DIR/${BASENAME}.docx"
PDF_OUTPUT="$BUILD_DIR/${BASENAME}.pdf"

info "Processing file: $ABS_PATH"

# Convert to DOCX using Asciidoctor and Pandoc
info "Generating DOCX..."
debug "Executing: asciidoctor --backend docbook --out-file - \"$ABS_PATH\" | pandoc --from docbook --to docx --output \"$DOCX_OUTPUT\""
asciidoctor --backend docbook --out-file - "$ABS_PATH" | pandoc --from docbook --to docx --output "$DOCX_OUTPUT"

# Validate DOCX creation
[[ -f "$DOCX_OUTPUT" ]] || error_exit "DOCX file not created."

info "DOCX file created: $DOCX_OUTPUT"

# Convert to PDF using Asciidoctor
info "Generating PDF..."
debug "Executing: asciidoctor-pdf \"$ABS_PATH\" --out-file \"$PDF_OUTPUT\""
asciidoctor-pdf "$ABS_PATH" --out-file "$PDF_OUTPUT"

# Validate PDF creation
[[ -f "$PDF_OUTPUT" ]] || error_exit "PDF file not created."

info "PDF file created: $PDF_OUTPUT"
info "Conversion complete."

