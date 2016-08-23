#!/bin/bash

### We have presentations that we want to deploy as both isoslides and as html documents (which play nice on mobile).  However we want to maintain one .Rmd file.  So this script will prepend the appropriate YAML header to the Rmd and deploy.
### bash may be the better approach than doing this in R.

echo "Enter the name of the file containing the document: "
read name_of_file

cat yaml1.yaml $name_of_file > ./deploy1_folder/tmp1.Rmd

cat $name_of_file > ./deploy2_folder/erase.Rmd
sed '/MIfooter/d' ./deploy2_folder/erase.Rmd > ./deploy2_folder/noDiv.Rmd
rm ./deploy2_folder/erase.Rmd
cat yaml2.yaml ./deploy2_folder/noDiv.Rmd > ./deploy2_folder/tmp2.Rmd
rm ./deploy2_folder/noDiv.Rmd

Rscript ./deploy1.R 
Rscript ./deploy2.R 

rm ./deploy1_folder/tmp1.Rmd
rm ./deploy2_folder/tmp2.Rmd

exit 0
