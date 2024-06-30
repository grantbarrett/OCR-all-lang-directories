# OCR-all.sh

## Description

`OCR-all.sh` is a script designed to process PDF files in specified directories using OCR (Optical Character Recognition). The script activates iTerm, sources Zsh configuration, and processes each PDF file found in the input directory. The processed files are saved in the output directory, and the original files are moved to the trash. This script utilizes `ocrmypdf` for OCR processing.

## Prerequisites

Before running this script, ensure you have the following prerequisites installed and configured:

- **Zsh**: The script is written to run in Zsh.
- **iTerm**: The script activates iTerm using AppleScript.
- **ocrmypdf**: The OCR processing is handled by `ocrmypdf`, which should be installed and accessible at `/opt/homebrew/bin/ocrmypdf`.
- **Homebrew**: Install Homebrew if not already installed to easily manage packages like `ocrmypdf`.
- **trash-cli**: The script uses the `trash` command to move processed files to the trash. Ensure it is installed and configured.

## Installation

1. **Install Homebrew** (if not already installed):
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2. **Install ocrmypdf**:
    ```bash
    brew install ocrmypdf
    ```

3. **Install trash-cli**:
    ```bash
    brew install trash
    ```

## Usage

1. **Set the Input and Output Directories**:
   Modify the `INPUT_DIR` and `OUTPUT_DIR` variables in the script to point to the desired input and output directories.

    ```sh
    INPUT_DIR="/path/to/input/directory"
    OUTPUT_DIR="/path/to/output/directory"
    ```

2. **Run the Script**:
   Ensure the script has execute permissions and then run it.

    ```bash
    chmod +x OCR-all.sh
    ./OCR-all.sh
    ```

## Script Details

- **Input Directory**: The script processes all subdirectories within the specified `INPUT_DIR`. Each subdirectory is expected to be named after the language code for OCR processing. Multiple languages can be used in the directory names, separated by a plus sign (`+`), e.g., `eng+spa`.
- **Output Directory**: Processed files are saved in the `OUTPUT_DIR` with `_ocr` appended to the filename.
- **OCR Processing**: Utilizes `ocrmypdf` with the following options:
  - `--jobs 6`: Run 6 OCR jobs in parallel.
  - `-l "$lang_code"`: Specify the language code for OCR.
  - `--tesseract-oem 3`: Use the Tesseract OCR engine mode 3.
  - `--output-type pdf`: Output the processed file as a PDF.
  - `--tesseract-timeout 600`: Set a timeout of 600 seconds for Tesseract.
  - `--force-ocr`: Force OCR on all input files.
  - `--jbig2-lossy`: Use JBIG2 lossy compression for monochrome images.
  - `--optimize 3`: Optimize the output PDF to reduce size.

## Documentation

For more information on `ocrmypdf`, please refer to the [ocrmypdf documentation](https://ocrmypdf.readthedocs.io/en/latest/).

### Language Packs

For optimal OCR performance, it is recommended to install `tessdata_best` language packs. Instructions for installing language packs can be found [here](https://ocrmypdf.readthedocs.io/en/latest/languages.html). The recommended language packs can be downloaded from the [Tesseract OCR GitHub page](https://tesseract-ocr.github.io/tessdoc/Data-Files-in-different-versions.html), which includes a table of available language codes.

## License

This project is licensed under the [Creative Commons Zero v1.0 Universal (CC0 1.0) Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/). You can copy, modify, distribute, and perform the work, even for commercial purposes, all without asking permission.

## Acknowledgments

Special thanks to the developers of `ocrmypdf` and `trash-cli` for their tools that made this script possible.
