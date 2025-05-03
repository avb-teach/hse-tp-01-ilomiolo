#!/bin/bash

if [ $# -ne 2 ]; then
    exit 1
fi

input_dir="$1"
output_dir="$2"

mkdir -p "$output_dir"

find "$input_dir" -type f | while read -r file; do
    filename=$(basename "$file")
    name="${filename%.*}"
    ext="${filename##*.}"
    [ "$name" = "$ext" ] && ext="" || ext=".$ext"
    path="$output_dir/$filename"
    c=1

    while [ -e "$path" ]; do
        path="$output_dir/${name}_$c$ext"
        ((c++))
    done

    cp "$file" "$path"
done