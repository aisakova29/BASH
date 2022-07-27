
#!/bin/bash

# для корректной работы скрипта требуется указать путь для сохранения файлов в переменной PTH

PTH='/home/ubuntu/'

name_directory=dir

name_newdirectory=new_dir

# создаем  пять директорий

for n in {1..5}; do
    mkdir "$PTH""$name_directory"-"$n"

    if [ $? -eq 0 ]
    then
       echo "Directory "$PTH""$name_directory"-"$i" successfully created"
    else
       echo "Could not create "$PTH""$name_directory"-"$i" directory" >&2
    fi

# создаем 1000 файлов с рандомными значениями в пяти ранее созданных директориях

    dir_pth="$PTH""$name_directory"-"$n"
    counter=0
    for i in {1..1000}; do
    dd if=/dev/urandom of="$dir_pth"/file-$( printf "$i"-$(date +%Y-%m-%d-%H-%M-%S)-size-"$n"K ) bs="$n" count=1024
    if [ $? -eq 0 ]
    then
       counter=$((counter+1))
    else
       echo "Could not create files" >&2
    fi
    done
       echo ""$counter" files in "$PTH""$name_directory"-"$n" successfully created"
  done

# создаем новую пустую директорию

mkdir "$PTH""$name_newdirectory"

 if [ $? -eq 0 ]
    then
       echo "New directory successfully created"
    else
       echo "Could not create new directory" >&2
    fi

# перемещаем 5 директорий с файлами в новую директорию

for dir in "$PTH""$name_directory"*; do
   cp -r "$dir" "$PTH""$name_newdirectory"
done

 if [ $? -eq 0 ]
    then
       echo "Copy of directories complete successfully"
    else
       echo "Could not copy directories" >&2
    fi

# сравниваем файлы в директориях и затем удаляем первые 5 созданных директорий

for i in {1..5}; do
    diff -r "$PTH""$name_directory"-"$i" "$PTH""$name_newdirectory"/"$name_directory"-"$i"
    rm -R "$PTH""$name_directory"-"$i"
    if [ $? -eq 0 ]
    then
       echo "Directory "$PTH""$name_directory"-"$i" delete successfully"
    else
       echo "Could not delete directory "$PTH""$name_directory"-"$i"" >&2
    fi

done

# удаляем файлы с нечетными номерами в директориях с четными номерми

find "$PTH""$name_newdirectory"/"$name_directory"-[0248] | egrep "file-([1,3,5,7,9]-|.[1,3,5,7,9]-|..[1,3,5,7,9]-)" | xargs rm -r

 if [ $? -eq 0 ]
    then
       echo "Files delete successfully"
    else
       echo "Could not delete files" >&2
  fi

