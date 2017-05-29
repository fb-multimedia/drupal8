echo "Enter the new Drupal Bootstrap(sass) subtheme name to create:"
read dwheel
#Create the subtheme directory in custom folder
mkdir custom
cp -r contrib/bootstrap/starterkits/sass custom/$dwheel

#Rename the files
mv custom/$dwheel/config/install/THEMENAME.settings.yml custom/$dwheel/config/install/$dwheel.settings.yml
mv custom/$dwheel/config/schema/THEMENAME.schema.yml custom/$dwheel/config/schema/$dwheel.schema.yml
mv custom/$dwheel/THEMENAME.libraries.yml custom/$dwheel/$dwheel.libraries.yml
mv custom/$dwheel/THEMENAME.theme custom/$dwheel/$dwheel.theme
mv custom/$dwheel/THEMENAME.starterkit.yml custom/$dwheel/$dwheel.info.yml

#Editing the file content with search/replace for THEMENAME and THEMETITLE
sed -i "s/THEMENAME/$dwheel/g" custom/$dwheel/config/schema/$dwheel.schema.yml
sed -i "s/THEMETITLE/$dwheel/g" custom/$dwheel/config/schema/$dwheel.schema.yml
sed -i "s/THEMENAME/$dwheel/g" custom/$dwheel/$dwheel.info.yml
sed -i "s/THEMETITLE/$dwheel/g" custom/$dwheel/$dwheel.info.yml

#Install the [Bootstrap Framework Source Files] 
wget -P custom/$dwheel https://github.com/twbs/bootstrap-sass/archive/master.zip
unzip custom/$dwheel/master.zip -d custom/$dwheel/
mv custom/$dwheel/bootstrap-sass-master custom/$dwheel/bootstrap
rm custom/$dwheel/master.zip

#Edit the libraries.yml and rename scss folder to sass
sed -i "s/css\//stylesheets\//g" custom/$dwheel/$dwheel.libraries.yml
mv custom/$dwheel/scss custom/$dwheel/sass

#compil with compass to create stylesheets/style.css file
cd custom/$dwheel
compass compile

#enable as default theme
cd ../..
drush en $dwheel
drush config-set system.theme default $dwheel
drush cache-rebuild
