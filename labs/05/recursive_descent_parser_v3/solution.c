//Daniel Flores Rodriguez
// A01734184

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define the structure for the Abstract Syntax Tree (AST)
typedef struct TreeNode {
    char name[5];
    struct TreeNode* children[3];  // At least 3 children for the grammar rules
    int childNo;
} TreeNode;

// Function to create a new AST node
TreeNode* createNewNode(const char* name) {
    TreeNode* newNode = (TreeNode*)malloc(sizeof(TreeNode));
    strcpy(newNode->name, name);
    newNode->childNo = 0;
    for (int i = 0; i < 3; i++) {
        newNode->children[i] = NULL;
    }
    return newNode;
}

// Function to parse the input string based on the grammar rules
TreeNode* parseS(char* input);
TreeNode* parseB(char* input);

// Function to print the AST in DOT format
void printTree(TreeNode* root) {
    if (root == NULL) {
        return;
    }

    for (int i = 0; i < root->childNo; i++) {
        printf("\"%s\" -> \"%s\"\n", root->name, root->children[i]->name);
    }

    for (int i = 0; i < root->childNo; i++) {
        printTree(root->children[i]);
    }
}

int main() {
    
    
    FILE* inputFile = fopen("tokens.txt", "r");


    if (inputFile == NULL) {
        perror("Error opening tokens.txt");
        return 1;
    }

    char token[100];

    //reading line per line
    while (fgets(token, sizeof(token), inputFile) != NULL) {
        // Remove the newline character
        token[strcspn(token, "\n")] = '\0'; //replace end space

        // Parse the token and build the AST
        TreeNode* root = parseS(token);

        // Check for syntax errors
        if (root != NULL) {
            // Print the AST in DOT format
            printf("digraph G {\n");
            printTree(root);
            printf("}\n");
        } else {
            printf("Syntax error in token: %s\n", token);
        }

        // Free the AST nodes
        free(root);
    }

    fclose(inputFile);
    return 0;
}

// Implementation of the parsing functions using recursive descent
TreeNode* parseS(char* input) {
    TreeNode* node = createNewNode("S");
    if (input[0] == 'a' && input[1] == 'b' && input[2] == 'c' && input[3] == '\0') {
        node->childNo = 3;
        node->children[0] = createNewNode("a");
        node->children[2] = createNewNode("c");
        return node;
    } else if (input[0] == 'a') {
        node->children[node->childNo++] = parseB(input + 1);
        if (node->children[0] != NULL && input[3] == 'c' && input[4] == '\0') {
            return node;
        }
    }
    free(node);
    return NULL;
}

TreeNode* parseB(char* input) {
    TreeNode* node = createNewNode("B");
    if (input[0] == 'b' && input[1] == 'c' && input[2] == '\0') {
        node->childNo = 1;
        node->children[0] = createNewNode("b");
        return node;
    } else if (input[0] == 'b') {
        if (input[1] == 'c' && input[2] == 'c' && input[3] == '\0') {
            node->childNo = 2;
            node->children[0] = createNewNode("b");
            node->children[1] = createNewNode("c");

            return node;
        } else {
            node->children[node->childNo++] = parseB(input + 1);
        }
    }
    free(node);
    return NULL;
}
