
#!/bin/bash

PTH='/home/ubuntu/'

for n in range {1..5}; do
    mkdir "$PTH"dir-"$n"
    dir_pth="$PTH"dir-"$n"
    for i in {1..10}; do
    dd if=/dev/urandom of="$dir_pth"/file-$( printf "$i"-$(date +%Y-%m-%d-%H-%M-%S)-size-"$n" ) bs="$n" count=1024
    done
done




PTH='/home/ubuntu/'
newdir=new_dir

mkdir "$PTH""$newdir"

for dir in "$PTH"dir*; do
   cp -r "$dir" "$PTH""$newdir"
done


for i in {1..5}; do
    diff -r /home/ubuntu/dir-"$i" /home/ubuntu/new_dir/dir-"$i"
    rm -R /home/ubuntu/dir-"$i"
done

find  /home/ubuntu/new_dir/dir-[0248]/ -type f -name 'file-[13579]-*' exec rm -f {} \;
ls -al /home/ubuntu/new_dir/dir-[0248]/ | egrep "file-('[1,3,5,7,9]{1}'|*.[1,3,5,7,9])"


