# Show guide files creation
for file in docs/guides/*.md; do
  date=$(grep "^date:" "$file" | cut -d' ' -f2)
  echo "$date - $(basename $file)"
done | sort -r
