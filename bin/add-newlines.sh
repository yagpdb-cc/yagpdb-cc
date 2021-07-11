for filename in ../src/**/*.go.tmpl; do
	sed -i -e '$a\' $filename
done
echo 'Done processing files'
