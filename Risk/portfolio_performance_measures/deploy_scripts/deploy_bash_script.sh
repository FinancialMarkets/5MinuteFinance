#!/bin/bash

### We have presentations that we want to deploy as both isoslides and as html documents (which play nice on mobile).  However we want to maintain one .Rmd file.  So this script will prepend the appropriate YAML header to the Rmd and deploy.
### bash may be the better approach than doing this in R.
cp ../../../global_graph_functions.R ./deploy1_folder
cp ../../../global_graph_functions.R ./deploy2_folder

echo "Enter the name of the file containing the document: "
read -e name_of_file

## strip yaml header if exists; files will tend to have yaml headers for development
## way to strip header from here
# http://stackoverflow.com/questions/28221779/how-to-remove-yaml-frontmatter-from-markdown-files
sed '1 { /^---/ { :a N; /\n---/! ba; d} }' ../$name_of_file > ./temporary_without_yaml.Rmd

cat yaml1.yaml temporary_without_yaml.Rmd > ./deploy1_folder/tmp1.Rmd

## remove all the footers from the html_doc version 
cat temporary_without_yaml.Rmd > ./deploy2_folder/erase.Rmd
sed '/MIfooter/d' ./deploy2_folder/erase.Rmd > ./deploy2_folder/noDiv.Rmd
cat yaml2.yaml ./deploy2_folder/noDiv.Rmd > ./deploy2_folder/tmp2.Rmd

## clean up
rm temporary_without_yaml.Rmd
rm ./deploy2_folder/erase.Rmd
rm ./deploy2_folder/noDiv.Rmd

## call deploy R scripts
Rscript ./deploy1.R 
Rscript ./deploy2.R 

## last clean up 
rm ./deploy1_folder/tmp1.Rmd
rm ./deploy2_folder/tmp2.Rmd
rm ./deploy1_folder/global_graph_functions.R
rm ./deploy2_folder/global_graph_functions.R

exit 0
