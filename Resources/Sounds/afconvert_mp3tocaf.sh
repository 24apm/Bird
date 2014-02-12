##
## Shell script to batch convert all files in a directory to caf sound format for iPhone
## Place this shell script a directory with sound files and run it: 'sh afconvert_wavtocaf.sh'
## Any comments to 'support@ezone.com'
##

for i in *.mp3; 
do afconvert -f caff -d LEI16@44100 -c 1 $i ${i%.mp3}.caf; 
echo "$i converted"
done