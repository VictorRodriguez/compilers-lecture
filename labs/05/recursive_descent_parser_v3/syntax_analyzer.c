// Desarrollo de aplicaciones avanzadas de ciencias computacionales
// Actividad 3.3. Analizador lexico + sintactico
// Daniela Hernández y Hernández    A01730397
// 30.10.2023


#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

/* --------------------
Grammar:
S -> aBc
B -> bc | b
-------------------- */


// **********************  AST generation with structs *************************************************
struct node {
  char item[5];
  struct node* left;
  struct node* middle;
  struct node* right;
};

// Create a new Node
struct node* create(char value[]) {
  struct node* newNode = malloc(sizeof(struct node));
  strcpy(newNode -> item, value);
  newNode -> left = NULL;
  newNode -> middle = NULL;
  newNode -> right = NULL;
  return newNode;
}

// Insert on the left of the node.
struct node* insertLeft(struct node* root, char value[]) {
  root -> left = create(value);
  return root -> left;
}

// Insert on the middle of the node
struct node* insertMiddle(struct node* root, char value[]) {
  root -> middle = create(value);
  return root -> middle;
}

// Insert on the right of the node
struct node* insertRight(struct node* root, char value[]) {
  root -> right = create(value);
  return root -> right;
}

// Print the AST with Dot Graphviz format
void printTree(struct node* root) {
  if(root == NULL) return;
  printf("digraph S {\n\tS [shape = plaintext];\n");
  struct node* left_child = root -> left;
  struct node* middle_child = root -> middle;
  struct node* right_child = root -> right;
  struct node* last_child = middle_child -> middle;
  printf("\tnode[shape = plaintext, fontcolor = \"red\"];\n\t%s -> %s\n", root -> item, left_child -> item);
  printf("\tnode[shape = plaintext, fontcolor = \"black\"];\n\t%s -> %s\n", root -> item, middle_child -> item);
  printf("\tnode[shape = plaintext, fontcolor = \"red\"];\n\t%s -> %s\n", root -> item, right_child -> item);
  printf("\t%s -> %s\n}\n\n", middle_child -> item, last_child -> item);
}


// ************************************** Syntax analyzer ********************************************************
char l;
bool B();
FILE *file; 
struct node* root;

void error(){
    printf("Error: cannot generate abstract syntax tree of this string.\n\n");
} 

// Match function
bool match(char t) {
    if (l == t) {
        l = fgetc(file);  // Read char from the file
        return true;
    } else {
        error();
        return false;
    }
}

//Rule S by the given grammar
bool S() {
    root = create("S");
    if (l == 'a') {
        insertLeft(root, "a");
        if(match('a') && B() && match('c')) {
            insertRight(root, "c");
            if(l == 'c') {
                match('c');
                if (l == '\n' || l == EOF) {
                    printf("**************** Parsing Successful *******************\n");
                    //printf("%s\n", ast2);
                    insertMiddle(root-> middle, "bc");
                    printTree(root);
                    return true;
                } 
            }
            if (l == '\n' || l == EOF) {
                printf("**************** Parsing Successful *******************\n");
                //printf("%s\n", ast1);
                insertMiddle(root-> middle, "b");
                printTree(root);
                return true;
            } else {
                error();
            }
		}
    } else {
		error();
	}
}

// Rule B by the given grammar
bool B() {
    insertMiddle(root, "B");
    if(l == 'b') {
        match('b');
        if(l == 'c') {
            return true;
        } else {
            error();
            return false;
        }
    } else {
        error();
        return false;
    }
}


int main() {
    file = fopen("tokens.txt", "r");  // Open the file named "tokens.txt" for reading
    if (file == NULL) {
        perror("Error opening the file");
        return 1;
    }

    while(true) {
        l = fgetc(file);  // Get the first character of a line
        if (l == EOF) {
            break; 
        }
        S();  // Process the line according to the grammar
        while (l != '\n' && l != EOF) {  // Skip to the end of the current line or to EOF
            l = fgetc(file);
        }
    }

    fclose(file);
    return 0;
}