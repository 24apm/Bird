##
## Shell script to batch convert all files in a directory to caf sound format for iPhone
## Place this shell script a directory with sound files and run it: 'sh afconvert_wavtocaf.sh'
## Any comments to 'support@ezone.com'
##

for f in *.wav; do
if  [ "$f" != "afconvert_wavtocaf.sh" ]
then
 afconvert -f caff -d ima4 $f
 echo "$f converted"
fi
done