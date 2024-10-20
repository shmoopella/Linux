#!/bin/bash

TEST1="-i kazan file.txt"
TEST2="-v Emilia file.txt"
TEST3="-c y file.txt"
TEST4="-l Hasan file.txt"
TEST5="-n bye file.txt"
TEST6="-e bla -e Kazan file.txt"

TEST7="-i kazan file.txt file2.txt"
TEST8="-v Emilia file.txt file2.txt"
TEST9="-c y file.txt file2.txt"
TEST10="-l Hasan file.txt file2.txt"
TEST11="-n bye file.txt file2.txt"
TEST12="-e y -e port file.txt file2.txt"

res_grep=0

./s21_grep $TEST1 >res1
grep $TEST1 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test1 success
else
    echo test1 fail
    res_grep=1
fi

./s21_grep $TEST2 >res1
grep $TEST2 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test2 success
else
    echo test2 fail
    res_grep=1
fi

./s21_grep $TEST3 >res1
grep $TEST3 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test3 success
else
    echo test3 fail
    res_grep=1
fi

./s21_grep $TEST4 >res1
grep $TEST4 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test4 success
else
    echo test4 fail
    res_grep=1
fi

./s21_grep $TEST5 >res1
grep $TEST5 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test5 success
else
    echo test5 fail
    res_grep=1
fi

./s21_grep $TEST6 >res1
grep $TEST6 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test6 success
else
    echo test6 fail
    res_grep=1
fi

./s21_grep $TEST7 >res1
grep $TEST7 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test7 success
else
    echo test7 fail
    res_grep=1
fi

./s21_grep $TEST8 >res1
grep $TEST8 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test8 success
else
    echo test8 fail
    res_grep=1
fi

./s21_grep $TEST9 >res1
grep $TEST9 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test9 success
else
    echo test9 fail
    res_grep=1
fi

./s21_grep $TEST10 >res1
grep $TEST10 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test10 success
else
    echo test10 fail
    res_grep=1
fi

./s21_grep $TEST11 >res1
grep $TEST11 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test11 success
else
    echo test11 fail
    res_grep=1
fi

./s21_grep $TEST12 >res1
grep $TEST12 >res2
DIF_RES="$(diff -s res1 res2)"
if [ "$DIF_RES" = "Files res1 and res2 are identical" ]
then
    echo test12 success
else
    echo test12 fail
    res_grep=1
fi

if [ $res_grep = 1 ]
then
    exit 1
else
    exit 0
fi