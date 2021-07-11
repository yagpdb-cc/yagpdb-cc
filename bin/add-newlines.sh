for filename in ../src/**/*.go.tmpl; do
	sed -i -e '$a\' $filename
	echo 'Done processing files'
done
