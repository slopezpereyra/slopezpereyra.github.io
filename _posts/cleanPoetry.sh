#!/bin/zsh
for file in *.md; do
  if grep -q "\[ Poesía \]" "$file"; then
    echo "$file"
    mv "$file" "F$file"
  fi
done
