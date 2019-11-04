// Michelle Sagnelli - Done w/ Juan Carlos Sanchez's help
#include <stdio.h>

static char tokenStream[100];
char currentToken;
int iter = 0;

void E();
void EDASH();
void T();
void TDASH();
void F();

void readFile(char *dest, const char *filename) {
  FILE *fp;
  fp = fopen(filename , "r");
  if(fp == NULL) {
    perror("Error opening file");
    return;
  }
  fgets(dest, 60, fp);
  for (int i = 0; i < 100; i++) {
    if (dest[i] == '\n') {
      dest[i] = '$';
      break;
    }
  }
  fclose(fp);
}

void compareToken(char token) {
  if (currentToken == token) {
    currentToken = tokenStream[++iter];
  }
}

void E() {
  if (currentToken == 'i' || currentToken == '(') {
    printf("\tE -- T;\n");
    printf("\tE -- ED;\n");
    T();
    EDASH();
  } else {
    printf("ERROR\n");
  }
}

void EDASH() {
  if (currentToken == '+') {
    printf("\tED -- plus;\n");
    printf("\tED-- T;\n");
    printf("\tED -- ED;\n");
    compareToken('+');
    T();
    EDASH();
  }
  else {
    printf("\tED -- ε;\n");
    return;
  }
}

void T() {
  if (currentToken == 'i' || currentToken == '(') {
    printf("\tT -- F;\n");
    printf("\tT -- TD;\n");
    F();
    TDASH();
  } else {
    printf("ERROR\n");
  }
}

void TDASH() {
  if (currentToken == '*') {
    printf("\tTD -- multiply;\n");
    printf("\tTD -- F;\n");
    printf("\tTD -- TD;\n");
    compareToken('*');
    E();
    compareToken('*');
  } else {
    printf("\tTD -- ε;\n");
    return;
  }
}

void F() {
  if (currentToken == '(') {
    printf("\tF -- (;\n");
    printf("\tF -- E;\n");
    printf("\tF -- );\n");
    compareToken('(');
    E();
    compareToken(')');
  } else if (currentToken == 'i') {
    printf("\tF -- id;\n");
    compareToken('i');
    compareToken('d');
  }
}

int main(int argc, char const *argv[]) {
  readFile(tokenStream, argv[2]);

  currentToken = tokenStream[iter];
  printf("graph G {\n");
  printf("\tS -- E;\n");
  E();
  if (currentToken == '$') {
    printf("}\n");
  }
  return 0;
}
