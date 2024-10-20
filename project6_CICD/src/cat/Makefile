all: s21_cat test

s21_cat: 
	gcc -Wall -Werror -Wextra s21_cat.c -o s21_cat

test:
	chmod 777 test.sh
	./test.sh

clean:
	rm -rf *.o s21_cat res1 res2