#!/bin/bash
while read extension; do
  code --install-extension $extension
done < "$(dirname "$0")/extensions.txt"
