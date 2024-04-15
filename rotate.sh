#!/bin/zsh

dir="/Users/anderssorlin/anso2001.github.io/posts"

# Loop through all files in the directory
if [ ! -d "$dir" ]; then
    echo "$dir is not a directory."
    exit 1
fi

# Loop through files in the target directory
for file in "$dir"/[0-9][0-9]*; do

  # Extract the first two digits and the rest of the filename
  prefix=$(basename "$file" | cut -c1-2)
  suffix=$(basename "$file" | cut -c3-)
  
  # Check if the prefix is numeric
  if ! [[ $prefix =~ ^[0-9]+$ ]]; then
    echo "Skipping $file: does not start with two digits."
    continue
  fi

  # Handle the case where the file starts with 00
  if [ "$prefix" -eq 49 ]; then
    new_prefix="00"
  else
    # Decrease the number by 1
    new_prefix=$(printf "%02d" $((10#$prefix + 1)))
  fi

  # Construct the new filename
  new_file="$dir/$new_prefix$suffix"

  # Rename the file
  mv "$file" "$new_file"
  
  echo "Renamed $file to $new_file"
done