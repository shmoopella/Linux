all: s21_grep test

s21_grep: 
	gcc -Wall -Werror -Wextra s21_grep.c -o s21_grep

test:
	chmod 777 test.sh
	./test.sh

clean:
	rm -rf *.o s21_grep res1 res2