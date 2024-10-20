#!/bin/bash

free_memory_kb=$(df / | awk 'NR==2{print $4}')
free_memory_mb=$(echo "$free_memory_kb 1024" | awk '{printf "%.0f", $1 / $2}')
date=_$(date +"%d%m%y")
abs_path_check='^/$'

max_file_length=248
ex_letters=$(echo $2| awk -F . '{print $2}')
root_dir=$1
root_file=$(echo $2| awk -F . '{print $1}')

count_d=100 #количество создаваемых директорий, по заданию - до ста
count_f=$(( $RANDOM % 5 + 1 )) # количество создаваемых файлов, по заданию - рандомное
sudo find / -type d | sed '/bin/d' > path_dir # создание файла, в котором будут судержаться пути директорий CHECK IT! BE CARIFULL!!!
count_path=$(awk 'END{print NR}' path_dir) # кол-во путей к директориям, записанных в этом файле


creation_directory_with_files() {
    echo "first free_mem $free_memory_mb"

    if [[ ${#root_dir} < 5 ]] #основа имени директории, не менее 5 символов
    then
        for (( i = ${#root_dir}; i < 5; i++ ))
        do
            root_dir="${dir_letters:0:1}$root_dir"
        done
    fi

    if [[ ${#root_file} < 5 ]]  #основа имени файлов, не менее 5 символов
    then
        for (( i = ${#root_file}; i < 5; i++ ))
        do
            root_file="${file_letters:0:1}$root_file"
        done
    fi

    for (( num_path_d=1; num_path_d <= count_path, $free_memory_mb > 1024; num_path_d++ ))
    do
        for (( letter_num=0, dir_count = 0 ; $dir_count < $count_d, $free_memory_mb > 1024; letter_num++)) #цикл, чтобы бежать по буквам, заданным для директории
        do
            dir_name=$root_dir
            index=0
            while [[ ${dir_name:$index:1} != "${dir_letters:$letter_num:1}" ]] #определение индекса в строке, куда нужно вставить букву
                do
                    ((index++))
                done

            for ((  ; $free_memory_mb > 1024 && ${#dir_name} < $max_file_length && $dir_count < $count_d; )) #вставка буквы в название директории
            do
                dir_name="${dir_name:0:$((index+1))}${dir_letters:$letter_num:1}${dir_name:$((index+1)):${#dir_name}}" #создание имени директории
                path=$(awk 'NR == '$num_path_d' {print $1}' path_dir)
                if [[ $path =~ $abs_path_check ]]
                then
                    full_dir_name="$path$dir_name$date"
                else 
                    full_dir_name="$path/$dir_name$date"
                fi

                if sudo mkdir $full_dir_name  #создание директории и проверка, успешно ли
                then
                    echo "$full_dir_name --- ${date:1:${#date}}" >> infod.log #запись о созданных директориях в лог файл, чтобы потом по нему можно было сделать удаление
                    echo "$full_dir_name --- ${date:1:${#date}}" >> info.log #запись о созданных директориях в лог файл, куда будут также записываться потом и созданные файл
                    ((dir_count++))
                    count_f=$(( $RANDOM % 5 + 1 )) #генерация количества файлов для созданной директории

                    for (( fletter_num=0, file_count = 0; $free_memory_mb > 1024 && $file_count < $count_f; fletter_num++ )) #цикл, чтобы бежать по буквам, заданным для файла
                    do
                        file_name=$root_file
                        indx=0
                    while [[ ${file_name:$indx:1} != "${file_letters:$fletter_num:1}" ]] #определяем индекса в строке, куда нужно вставить букву
                            do
                                ((indx++))
                            done

                        for ((  ; $free_memory_mb > 1024 && ${#file_name} < $max_file_length && $file_count < $count_f; )) #вставка буквы в название файла
                                do
                                    file_name="${file_name:0:$((indx+1))}${file_letters:$fletter_num:1}${file_name:$((indx+1)):${#file_name}}" # создание имени файла
                                    if sudo fallocate -l $num_size"MB" "$full_dir_name/$file_name$date.$ex_letters"  #создание файла и проверка успешности создания
                                    then
                                        echo "$full_dir_name/$file_name$date.$ex_letters --- ${date:1:${#date}} --- $num_size Mb" >> info.log #запись в лог файл
                                        free_memory_kb=$(df / | awk 'NR==2{print $4}')
                                        free_memory_mb=$(echo "$free_memory_kb 1024" | awk '{printf "%.0f", $1 / $2}')
                                        echo "free_mem_lost: $free_memory_mb"
                                        ((file_count++))
                                    fi
                                done
                    done
                else
                    ((num_path_d++))
                    continue
                fi
            done
        done
    done
}