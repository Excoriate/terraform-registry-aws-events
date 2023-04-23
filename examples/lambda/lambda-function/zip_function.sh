#!/bin/bash
#
# A script to zip a source file (default: handler.js) located in a specified directory
# into a zip file (default: lambda-function.zip)
#
# Usage: ./zip_lambda.sh [output_file_name] [source_file_name] [source_directory]
#

# Constants
readonly SCRIPT_NAME=$(basename "$0")

# Functions

# Usage: log MESSAGE
# Log a message to stderr with a timestamp
log() {
  local message="$1"
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "[$timestamp] $message" >&2
}

# Usage: error_exit MESSAGE
# Log an error message and exit with a non-zero status
error_exit() {
  local message="$1"
  log "ERROR: $message"
  exit 1
}

# Main script

# Check the number of arguments and set the default values
output_file_name="lambda-function.zip"
source_file_name="handler.js"
source_directory="."

if [[ $# -gt 3 ]]; then
  error_exit "Invalid number of arguments. Usage: $SCRIPT_NAME [output_file_name] [source_file_name] [source_directory]"
elif [[ $# -eq 3 ]]; then
  output_file_name="$1"
  source_file_name="$2"
  source_directory="$3"
elif [[ $# -eq 2 ]]; then
  output_file_name="$1"
  source_file_name="$2"
elif [[ $# -eq 1 ]]; then
  output_file_name="$1"
fi

# Check if the source directory exists
if [[ ! -d "$source_directory" ]]; then
  error_exit "Source directory '$source_directory' does not exist."
fi

# Check if the source file exists in the source directory
if [[ ! -f "${source_directory}/${source_file_name}" ]]; then
  error_exit "Source file '$source_file_name' does not exist in directory '$source_directory'."
fi

log "Zipping '${source_directory}/${source_file_name}' into '$output_file_name'"

# Zip the source file
zip -j "$output_file_name" "${source_directory}/${source_file_name}" || error_exit "Failed to zip '${source_directory}/${source_file_name}' into '$output_file_name'"

log "Successfully zipped '${source_directory}/${source_file_name}' into '$output_file_name'"
