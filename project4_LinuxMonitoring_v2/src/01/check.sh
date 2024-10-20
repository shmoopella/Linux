path_check='^/[a-zA-Z0-9/_-]*[^/]$'
check_on_abs_path='^/$'

dir_check='^[A-Za-z]{1,7}$'
file_check='^[A-Za-z]{1,7}\.{1,1}[A-Za-z]{1,3}$'

count_dir_check='^[1-9]+$'
count_file_check='^[0-9]+$'


size_of_file_check='^[0-9]+kb|Kb|KB|kB$'
num_size=$(echo $6 | sed 's/'[kK][bB]'//')

check() {
    if [ $count_param -ne 6 ]
    then
        echo "Incorrect input! Run the script using 6 parameters."
        exit 1

    elif ! [[ $1 =~ $path_check || $1 =~ $check_on_abs_path ]]
    then
        echo "Incorrect inpit! The first parameter must be an absolute path to directory without \"/\" in the end."
        exit 2

    elif ! [[ -d $1 ]]
    then
        echo "Incorrect input! No such directory $1."
        exit 3

    elif ! [[ -w $1 ]]
    then
        echo "$1: permissions denied"
        exit 4

    elif ! [[ $2 =~ $count_dir_check ]]
    then
        echo "Incorrect input in the second parameter! Use only numbers and count of folder should be at least 1."
        exit 5


    elif ! [[ $3 =~ $dir_check ]]
    then
        echo "Incorrect input in the third parameter! A folder's name must contain only A-Z, a-z not repeat letters and you can use not more 7 letters."
        exit 6

    elif ! [[ $4 =~ $count_file_check ]]
    then
        echo "Incorrect input in the fourth parameter! Use only numbers."
        exit 7

    elif ! [[ $5 =~ $file_check ]]
    then
        echo "Incorrect input in the fifth parameter!"
        echo "A file\`s name must contain only A-z, a-z letters and you can use not more 7 letters for a name and not more 3 letters for an extension. Letters in a name and in an extension can\`t repeat. Example: sdf.ex"
        exit 8

    elif ! [[ $6 =~ $size_of_file_check ]]
    then
        echo "Input error in the sixth parameter! Please, write size of files in kb. Example: 123kb."
        exit 9
    
    elif [ $num_size -gt 100 ]
    then
        echo "Input error in sixth parameter! Size can\`t be over 100kb"
        exit 10
    fi
}
