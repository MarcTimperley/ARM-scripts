# handbrake convert and move to use with the ARM
#!/usr/bin/env bash
PATH=$PATH:/bin:/usr/bin
export PATH
SOURCE="$1/*.mkv"
ls -alh $SOURCE
printf -v NOW '%(%F)T';
#script_log="./log/log_$NOW.log"
#echo $script_log
for f in $SOURCE
do
  (
  #exec 1>>$script_log
  printf '%(%T)T: '
  echo "Processing $f..."
  OUTFILE=${f/.mkv/.mp4}
  OUTFILE=${OUTFILE//\//-}
  OUTFILE=${OUTFILE//--/-}
  OUTFILE=${OUTFILE,,}
  arr=(${OUTFILE//_/ })
  printf -v OUTFILE %s "${arr[@]^}"
  printf '%(%T)T: '
  echo " Converting to $OUTFILE..."
#  /usr/bin/HandBrakeCLI -Z "HQ 1080p30 Surround" -i $f -o $OUTFILE -m

  ( HandBrakeCLI -Z "HQ 1080p30 Surround" -i $f -o $OUTFILE -m | 
    unbuffer -p grep -i "encoding: task " | 
    unbuffer -p cut -c24-25
  ) | zenity --progress --auto-close --title="Encoding" --text="$OUTFILE..." --width=600
  printf '%(%T)T: '
  echo "Finished conversion to $OUTFILE..."
  echo ""
  ) 
#  ) & # execute in parallel
done
wait
printf '%(%T)T: '
FOLDER=${SOURCE/\/*.mkv/}
echo "moving $FOLDER to ConvertedToMP4/"
mv ./$FOLDER ./ConvertedToMP4
printf '%(%T)T: '
echo "Completed conversion of $FOLDER"
zenity --info --title="Encoding" --text="Completed conversion of $FOLDER" --width=600
echo ""
echo ""
