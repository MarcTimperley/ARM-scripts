# ARM-scripts
Scripts and tools for [Automatic Ripper Machine](https://github.com/automatic-ripping-machine/automatic-ripping-machine)

 - .abcde.conf - configuration file for abcde audio ripper
 - arm.yml - configuration for ARM itself
 - convert.sh - automated Handbrake conversion and content move with progress indicators

ARM is a great tool to automate ripping CDs and DVDs, and I have added some additional scripts to improve the process (IMHO).

### Dependencies

 - lame - for mp3 output
 - cdparanoia - for the ripping
 - HandBrakeCLI - for the DVD conversion
 - zenity - for notifications using convert.sh
 - unbuffer - used by zenity output
 - picard - used if the tracklisting isn't available

## Processing Music CDs

 1. Put the CD in
 2. When it ejects, the mp3 files, cover art and m3u playlist will be in /home/arm/media/music/mp3/[Artist]/[Album Title]
 
 ### Tracklisting Issues
 
 If it doesn't pick up the tracklisting, see [How to Add Tracklisting](https://musicbrainz.org/doc/How_to_Add_Disc_IDs) for details.
 
 1. Then delete the /home/arm/abcde.[DISCID] folder 
 1. Next, put the disk back in to rip with the corrct tracklisting
 2. You can check progress by monitoring /home/arm/logs/music_cd.log

## Processing DVDs

 1. Put the DVD in
 2. When it ejects, the mkv files will be in /home/arm/media/completed
 3. To convert to mp4 (High Quality 1080p), run ```./convert.hs [foldername]``` from /home/arm/media/completed
 4. This converts each of the mkv files in turn to mp4 files in the /home/arm/media/completed folder and reformats the filenames. It then moves the /home/arm/media/complete/[foldername] to the /home/arm/media/completed/ConvertedToMP4 folder. This folder can be kept if you want the original mkv files and have sufficient space or can be emptied if they are not needed.
