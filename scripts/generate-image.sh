#!/bin/bash

# Image Generation Script for Courseware
# Usage: ./scripts/generate-image.sh "prompt" "output-filename"
#
# Example:
#   ./scripts/generate-image.sh "A technical diagram showing..." "01-transformer-arch"
#
# API Key can be set via DOUBAO_IMAGE_API_KEY environment variable

set -e

# Configuration
API_KEY="${DOUBAO_IMAGE_API_KEY:-9678778f-3746-4867-91ab-04bee1e1ad5f}"
API_URL="https://ark.cn-beijing.volces.com/api/v3/images/generations"
MODEL="doubao-seedream-5-0-260128"
OUTPUT_DIR="assets/images"

# Check arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 \"prompt\" \"output-filename\" [--no-watermark]"
    echo ""
    echo "Arguments:"
    echo "  prompt          Image description (English recommended for better results)"
    echo "  output-filename Output filename without extension (e.g., 01-transformer-arch)"
    echo "  --no-watermark  Disable watermark (default: enabled)"
    echo ""
    echo "Example:"
    echo "  $0 \"A technical diagram showing Transformer architecture\" \"01-transformer-arch\""
    exit 1
fi

PROMPT="$1"
FILENAME="$2"
WATERMARK="true"

# Check for --no-watermark flag
if [ "$3" == "--no-watermark" ]; then
    WATERMARK="false"
fi

OUTPUT_PATH="${OUTPUT_DIR}/${FILENAME}.jpeg"

echo "========================================"
echo "Image Generation"
echo "========================================"
echo "Prompt: $PROMPT"
echo "Output: $OUTPUT_PATH"
echo "Watermark: $WATERMARK"
echo ""

# Create output directory if not exists
mkdir -p "$OUTPUT_DIR"

# Call API
echo "Calling API..."
RESPONSE=$(curl -s -X POST "$API_URL" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"model\": \"$MODEL\",
    \"prompt\": \"$PROMPT\",
    \"sequential_image_generation\": \"disabled\",
    \"response_format\": \"url\",
    \"size\": \"2K\",
    \"stream\": false,
    \"watermark\": $WATERMARK
  }")

# Check for errors
if echo "$RESPONSE" | grep -q '"error"'; then
    echo "Error: API returned an error"
    echo "$RESPONSE" | head -200
    exit 1
fi

# Extract URL from response
IMAGE_URL=$(echo "$RESPONSE" | grep -o '"url":"[^"]*"' | head -1 | sed 's/"url":"//;s/"$//')

if [ -z "$IMAGE_URL" ]; then
    echo "Error: Failed to extract image URL from response"
    echo "Response: $RESPONSE"
    exit 1
fi

echo "Image URL obtained"

# Download image
echo "Downloading image..."
curl -L -o "$OUTPUT_PATH" "$IMAGE_URL" --connect-timeout 30 --max-time 120

if [ -f "$OUTPUT_PATH" ] && [ -s "$OUTPUT_PATH" ]; then
    FILE_SIZE=$(stat -f%z "$OUTPUT_PATH" 2>/dev/null || stat --printf="%s" "$OUTPUT_PATH" 2>/dev/null || echo "unknown")
    echo ""
    echo "========================================"
    echo "✓ Success!"
    echo "========================================"
    echo "File: $OUTPUT_PATH"
    echo "Size: $FILE_SIZE bytes"
    echo ""
    echo "Markdown usage:"
    echo "  ![](../$OUTPUT_PATH)"
    echo ""
else
    echo "Error: Failed to download image or file is empty"
    exit 1
fi
