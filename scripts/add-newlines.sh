shopt -s globstar

for filename in ../src/**/*.go.tmpl; do
	echo "Adding EOF newline for $filename"
	sed -i -e '$a\' $filename
done
echo 'Added EOF newlines in all custom command files'
