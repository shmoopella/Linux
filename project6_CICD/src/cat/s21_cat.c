#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void pickupflags(char *check, char **argv);
void output(int check, FILE *from);
void b_flag(FILE *from);
void e_flag(FILE *from);
void E_flag(FILE *from);
void n_flag(FILE *from);
void s_flag(FILE *from);
void t_flag(FILE *from);
void T_flag(FILE *from);
void v_flag(FILE *from);

int main(int argc, char **argv) {
  FILE *from = NULL;
  char check = 0;
  int i = 1;
  pickupflags(&check, argv);
  if (check != 0) {
    i++;
  }
  for (; i < argc; i++) {
    from = fopen(argv[i], "r");
    if (!from) {
      fflush(stdout);
      perror(argv[i + 1]);
      continue;
    }
    output(check, from);
    fclose(from);
  }
  return 0;
}

void pickupflags(char *check, char **argv) {
  if (argv[1][0] == '-') {
    switch (argv[1][1]) {
    case 'b':
      *check = 'b';
      break;
    case 'e':
      *check = 'e';
      break;
    case 'n':
      *check = 'n';
      break;
    case 's':
      *check = 's';
      break;
    case 't':
      *check = 't';
      break;
    case 'E':
      *check = 'E';
      break;
    case 'T':
      *check = 'T';
      break;
    case 'v':
      *check = 'v';
      break;
    case '-':
      if (!strcmp(argv[1], "--number-nonblank")) {
        *check = 'b';
      }
      if (!strcmp(argv[1], "--number")) {
        *check = 'n';
      }
      if (!strcmp(argv[1], "--squeeze-blank")) {
        *check = 's';
      }
      break;
    default:
      fprintf(stderr, "cat: illegal option -- %c\n", argv[1][1]);
      exit(0);
    }
  }
}

void output(int check, FILE *from) {
  int c = 0;
  switch (check) {
  case 'b':
    b_flag(from);
    break;
  case 'e':
    e_flag(from);
    break;
  case 'n':
    n_flag(from);
    break;
  case 's':
    s_flag(from);
    break;
  case 't':
    t_flag(from);
    break;
  case 'E':
    E_flag(from);
    break;
  case 'T':
    T_flag(from);
    break;
  case 'v':
    v_flag(from);
    break;
  default:
    while ((c = fgetc(from)) != EOF) {
      putchar(c);
    }
  }
}

void b_flag(FILE *from) {
  int c = 0;
  int count = 1;
  int prev = 0;
  int new_str = 1;
  while ((c = fgetc(from)) != EOF) {
    if (prev == '\n') {
      new_str = 1;
    }
    if (new_str && c != '\n') {
      printf("%6d\t", count);
      count++;
    }
    putchar(c);
    prev = c;
    new_str = 0;
  }
}

void e_flag(FILE *from) {
  int c = 0;
  while ((c = fgetc(from)) != EOF) {
    if (c == '\n') {
      putchar('$');
    }
    if (c >= 0 && c < 32 && c != 9 && c != 10) {
      printf("^%c", c + 64);
    } else {
      putchar(c);
    }
  }
}

void n_flag(FILE *from) {
  int c = 0;
  int count = 1;
  int prev = 0;
  printf("%6d\t", count);
  count++;
  while ((c = fgetc(from)) != EOF) {
    if (prev == '\n') {
      printf("%6d\t", count);
      count++;
    }
    putchar(c);
    prev = c;
  }
}

void E_flag(FILE *from) {
  int c = 0;
  while ((c = fgetc(from)) != EOF) {
    if (c == '\n') {
      putchar('$');
    }
    putchar(c);
  }
}

void T_flag(FILE *from) {
  int c = 0;
  while ((c = fgetc(from)) != EOF) {
    if (c == '\t') {
      putchar('^');
      putchar('I');
    } else {
      putchar(c);
    }
  }
}

void t_flag(FILE *from) {
  int c = 0;
  while ((c = fgetc(from)) != EOF) {
    if (c >= 0 && c < 32 && c != 10) {
      printf("^%c", c + 64);
    } else if (c == 127) {
      printf("^?");
    } else {
      putchar(c);
    }
  }
}

void v_flag(FILE *from) {
  int c = 0;
  while ((c = fgetc(from)) != EOF) {
    if (c >= 0 && c < 32 && c != 9 && c != 10) {
      printf("^%c", c + 64);
    } else {
      putchar(c);
    }
  }
}

void s_flag(FILE *from) {
  int c = 0;
  int flag = 0;
  int prev_symb = '\n';
  while ((c = fgetc(from)) != EOF) {
    if (prev_symb == '\n' && c == '\n') {
      if (!flag) {
        putchar(c);
        flag = 1;
      }
      prev_symb = c;
    } else {
      putchar(c);
      prev_symb = c;
      flag = 0;
    }
  }
}
