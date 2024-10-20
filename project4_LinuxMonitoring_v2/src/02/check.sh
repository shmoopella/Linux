#!/bin/bash

dir_check='^[A-Za-z]{1,7}$'
file_check='^[A-Za-z]{1,7}\.{1,1}[A-Za-z]{1,3}$'
size_of_file_check='^[0-9]+mb|Mb|MB|mB$'
num_size=$(echo $3 | sed 's/'[mM][bB]'//')


check() {
    if [ $count_param -ne 3 ]
    then
        echo "Incorrect input! Run the script using 3 parameters."
        exit 1

    elif ! [[ $1 =~ $dir_check ]]
    then
        echo "Incorrect input in the first parameter! A folder's name must contain only A-Z, a-z not repeat letters and you can use not more 7 letters."
        exit 2

    elif ! [[ $2 =~ $file_check ]]
    then
        echo "Incorrect input in the second parameter!"
        echo "A file\`s name must contain only A-z, a-z letters and you can use not more 7 letters for a name and not more 3 letters for an extension. Letters in a name and in an extension can\`t repeat. Example: sdf.ex"
        exit 3
    
    elif [ $num_size -gt 100 ]
    then
        echo "Input error in third parameter! Size can\`t be over 100mb"
        exit 4

    elif ! [[ $3 =~ $size_of_file_check ]]
    then
        echo "Input error in the third parameter! Please, write size of files. Example: 123mb."
        exit 5
    fi
}
