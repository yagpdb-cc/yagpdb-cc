shopt -s globstar

grep -o 'file=\.\./.*\.go\.tmpl' ../website/docs/**/*.{md,mdx} | while read -r line ; do
	# sed outputs lines like 'filename:match' with the above options.
	# Split on ':' to get the filename and match as separate values.
	filename=$(cut -d: -f1 <<< $line)
	match=$(cut -d: -f2 <<< $line)
	
	# Remove '../website/docs/' from the filename, then remove the extension to get the slug.
	slug="$(echo "${filename//..\/website\/docs\/}" | cut -f 1 -d '.')"
	url="https://yagpdb-cc.github.io/$slug"

	# To find the filename for the code, we remove everything in the match until we see a 's' (start of 'src').
	# Then, we add a '../' to adjust for the location of this script, and there we go - we have our file : )
	dst="../s${match#*s}"

	echo "Linking to website (URL $url) for file $dst"

	# Now, replace the links in the code with the website links.
	sed -i -e "s,See <[^>]*> for more information\.,See <$url> for more information.," $dst
done
echo 'Linked to website in all custom command files'
