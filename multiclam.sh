#!/bin/bash
# Multi Clam (version 0.3 dev build 1), a shell script that turns ClamAV's clamscan utility multi-threaded
# As a dev build, the thread count is set to 6 for testing

threads=0 #Current threads being used
maxthreads=6 #Thread use limit
phase=0 #Files added to segment
maxphase=0 #Segment size
manual=no #Segment size mode
count=0
fileamt=0

case $1 in #Command arguments (unfinished)
    h | -h | *help*) #To be added
    ;;
    -m)
        maxphase=$2 #Unfinished
        manual=yes
    ;;
    -d)
        if [[ -d $2 ]]
        then
            cd "$2"
        else
            echo "You need to specify a directory that exists"
            return
        fi
    ;;
esac

for i in * #Count the amount of files for auto mode
do
    ((fileamt+=1))
done

if [[ $manual != yes ]]
then
    ((maxphase=$fileamt/$maxthreads)) #In auto mode, the amount of files processed per thread depends on both the amount of files and threads
fi

echo $maxphase

for i in * #Divide the directory's files into segments for scanning. Once each segment is full, it will be scanned
do
    if (($threads >= $maxthreads)) #Maximum simultaneous scans allowed cannot surpass the max threads assigned
    then
        wait
        ((threads=0))
    fi

    if ((phase>$maxphase)) #Once a segment is full, it's scanned
    then
        clamscan -r -f scanphase$count.txt &
        ((count+=1))
        phase=0
        ((threads+=1))
    fi
    echo $i >> scanphase$count.txt
    ((phase+=1))
done

if ((phase!=0)) #Additional check for files that missed the scanning (not needed, stays for assurance)
then
    clamscan -r -f scanphase$count.txt
fi

for i in *
do
    if [[ $i == *"scanphase"* ]]
    then
        rm "$i"
    fi
done
