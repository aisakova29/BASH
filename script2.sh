#!/bin/bash

PTH='/home/ubuntu/'

name_directory=dir
name_newdirectory=new_dir

for n in {1..5}; do
    mkdir "$PTH""$name_directory"-"$n"

    if [ $? -eq 0 ]
    then
       echo "Directory successfully created"
    else
       echo "Could not create directory" >&2
    fi

    dir_pth="$PTH""$name_directory"-"$n"

    for i in {1..100}; do
    dd if=/dev/urandom of="$dir_pth"/file-$( printf "$i"-$(date +%Y-%m-%d-%H-%M-%S)-size-"$n"K ) bs="$n" count=1024
    if [ $? -eq 0 ]
    then
       echo "Files successfully created"
    else
       echo "Could not create files" >&2
    fi
done
done



mkdir "$PTH""$name_newdirectory"

 if [ $? -eq 0 ]
    then
       echo "New directory successfully created"
    else
       echo "Could not create new directory" >&2
    fi

for dir in "$PTH""$name_directory"*; do
   cp -r "$dir" "$PTH""$name_newdirectory"
done


 if [ $? -eq 0 ]
    then
       echo "Copy of directories complete successfully"
    else
       echo "Could not copy directories" >&2
    fi

