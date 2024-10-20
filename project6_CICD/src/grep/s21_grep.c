#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void pickupflags(char *check, char **argv);
int check_n(char *src);
void output(int check, FILE *from, regex_t compiled, int i, char **argv,
            int argc);
int check_e(char **argv, int argc);
void output_e(FILE *from, int argc, char **argv);

int main(int argc, char **argv) {
  FILE *from = NULL;
  char check = 0;
  int i = 1;
  regex_t compiled = {0};
  if (argc < 3) {
    fprintf(stderr, "Too few arguments\n");
  } else {
    pickupflags(&check, argv);
    if (check) {
      i++;
    }
    if (check != 'e') {
      if (check == 'i') {
        regcomp(&compiled, argv[i], REG_ICASE);
      } else {
        regcomp(&compiled, argv[i], REG_EXTENDED);
      }
      i++;
      for (; i < argc; i++) {
        from = fopen(argv[i], "r");
        if (!from) {
          fflush(stdout);
          perror(argv[i]);
          continue;
        }
        output(check, from, compiled, i, argv, argc);
        fclose(from);
      }
      regfree(&compiled);
    } else {
      output_e(from, argc, argv);
    }
  }
  return 0;
}

int check_n(char *src) {
  int flag = 0;
  for (int i = 0; src[i] != '\0'; i++) {
    if (src[i] == '\n')
      flag = 1;
  }
  return flag;
}

void output_e(FILE *from, int argc, char **argv) {
  int j = 0;
  int count_e = 0;
  char **ptr_pattern = NULL;
  int file_index = 0;
  regex_t compiled_e = {0};
  size_t len = 0;
  char *src = NULL;
  int multifile = 0;
  count_e = check_e(argv, argc);
  ptr_pattern = malloc(count_e * sizeof(char *));
  for (int i = 1; i < argc; i++) {
    if (argv[i][0] == '-' && argv[i][1] == 'e') {
      i++;
      ptr_pattern[j] = malloc(strlen(argv[i]) * sizeof(char));
      strcpy(ptr_pattern[j], argv[i]);
      j++;
      file_index = i + 1;
    }
  }
  if (file_index + 1 < argc) {
    multifile = 1;
  }
  for (; file_index < argc; file_index++) {
    from = fopen(argv[file_index], "r");
    if (!from) {
      fflush(stdout);
      perror(argv[file_index]);
      continue;
    }
    while (getline(&src, &len, from) != EOF) {
      for (int i = 0; i < count_e; i++) {
        regcomp(&compiled_e, ptr_pattern[i], REG_EXTENDED);
        if (!regexec(&compiled_e, src, 0, 0, 0)) {
          if (multifile) {
            printf("%s:", argv[file_index]);
          }
          printf("%s", src);
          if (!check_n(src)) {
            putchar('\n');
          }
          regfree(&compiled_e);
          break;
        }
        regfree(&compiled_e);
      }
    }
    fclose(from);
  }
  free(src);
  for (int i = 0; i < count_e; i++) {
    free(ptr_pattern[i]);
  }
  free(ptr_pattern);
}

void output(int check, FILE *from, regex_t compiled, int i, char **argv,
            int argc) {
  size_t len = 0;
  char *src = NULL;
  int count = 0;
  int num_line = 1;
  switch (check) {
  case 'i':
    while (getline(&src, &len, from) != EOF) {
      if (!regexec(&compiled, src, 0, 0, 0)) {
        if (argc > 4) {
          printf("%s:", argv[i]);
        }
        printf("%s", src);
        if (!check_n(src)) {
          putchar('\n');
        }
      }
    }
    free(src);
    break;
  case 'v':
    while (getline(&src, &len, from) != EOF) {
      if (regexec(&compiled, src, 0, 0, 0)) {
        if (argc > 4) {
          printf("%s:", argv[i]);
        }
        printf("%s", src);
        if (!check_n(src)) {
          putchar('\n');
        }
      }
    }
    free(src);
    break;
  case 'c':
    while (getline(&src, &len, from) != EOF) {
      if (!regexec(&compiled, src, 0, 0, 0)) {
        count++;
      }
    }
    if (argc > 4) {
      printf("%s:", argv[i]);
    }
    printf("%d\n", count);
    free(src);
    break;
  case 'l':
    while (getline(&src, &len, from) != EOF) {
      if (!regexec(&compiled, src, 0, 0, 0)) {
        count = 1;
      }
    }
    if (count) {
      printf("%s\n", argv[i]);
    }
    free(src);
    break;
  case 'n':
    while (getline(&src, &len, from) != EOF) {
      if (!regexec(&compiled, src, 0, 0, 0)) {
        if (argc > 4) {
          printf("%s:", argv[i]);
        }
        printf("%d:%s", num_line, src);
        if (!check_n(src)) {
          putchar('\n');
        }
      }
      num_line++;
    }
    free(src);
    break;
  default:
    while (getline(&src, &len, from) != EOF) {
      if (!regexec(&compiled, src, 0, 0, 0)) {
        if (argc > 3) {
          printf("%s:", argv[i]);
        }
        printf("%s", src);
        if (!check_n(src)) {
          putchar('\n');
        }
      }
    }
    free(src);
    break;
  }
}

void pickupflags(char *check, char **argv) {
  if (argv[1][0] == '-') {
    switch (argv[1][1]) {
    case 'e':
      *check = 'e';
      break;
    case 'i':
      *check = 'i';
      break;
    case 'v':
      *check = 'v';
      break;
    case 'c':
      *check = 'c';
      break;
    case 'l':
      *check = 'l';
      break;
    case 'n':
      *check = 'n';
      break;
    default:
      fprintf(stderr, "grep: illegal option -- %c\n", argv[1][1]);
      exit(0);
    }
  }
}

int check_e(char **argv, int argc) {
  int count = 1;
  for (int i = 3; i < argc; i++) {
    if (argv[i][0] == '-')
      count++;
  }
  return count;
}
