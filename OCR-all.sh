#!/bin/zsh

# Activate iTerm
osascript -e 'tell application "iTerm" to activate'

# Source Zsh configuration
# source ~/.zshrc

# Define input and output directories
INPUT_DIR="/your/input/parent/directory/containing/language-directories"
OUTPUT_DIR="/your/output/directory"

# Function to process a single PDF with OCR
process_pdf() {
  local pdf_path="$1"
  local lang_code="$2"
  local filename="$(basename "${pdf_path%.*}")"
  local ocr_file="${OUTPUT_DIR}/${filename}_ocr.pdf"

  echo "Processing $pdf_path with language $lang_code..."

  # Skip files that have been processed before
  if [[ "${pdf_path}" == *_ocr.pdf ]]; then
    return
  fi

  # Process with OCRmyPDF
  /opt/homebrew/bin/ocrmypdf --jobs 6 -l "$lang_code" --tesseract-oem 3 --output-type pdf --tesseract-timeout 600 --force-ocr --jbig2-lossy --optimize 3 "$pdf_path" "$ocr_file"

  if [ $? -eq 0 ]; then
    echo "OCR processed $pdf_path to $ocr_file"
    trash "$pdf_path" # Move the original file to the trash
    echo "Moved $pdf_path to trash."
  else
    echo "OCRmyPDF failed on $pdf_path"
  fi
}

# Loop through directories and process each PDF
for lang_dir in "$INPUT_DIR"/*; do
  if [[ -d "$lang_dir" ]]; then
    lang_code="$(basename "$lang_dir")"
    pdf_count=$(find "$lang_dir" -name "*.pdf" | wc -l)
    if [ "$pdf_count" -eq 0 ]; then
      continue
    fi
    for pdf_file in "$lang_dir"/*.pdf; do
      if [[ -f "$pdf_file" ]]; then
        process_pdf "$pdf_file" "$lang_code"
      fi
    done
  fi
done

echo "Processing complete."
