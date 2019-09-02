/*
    Diego Alonso Martinez de Dios A01228042
    Note: I'm writting this code with a Stack data structure I developed 
    for a balanced parenthesis program I did a while ago. As evidence of this I'll link 
    my GitLab repository with the code I wrote a few months ago: https://gitlab.com/DiegoDeDios/my-compiler/tree/master/0_fundamentals
    
    Will need: A pushdown automatha
    State where it knows line is a comment


*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
// ---- Stack Data Structure ------
struct Node{
	char key;
	struct Node* next;
};
struct Node* newNode(char key){
	struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
	newNode->key=key;
	newNode->next= NULL;
	return newNode;
};
int isEmpty(struct Node* head){
	return !head;
}
void push(struct Node** head, char key){
	struct Node* temp = newNode(key);
	temp->next = *head;
	*head = temp;
}
char pop(struct Node** head){
	if(isEmpty(*head)){
		exit(-1);
	}
	struct Node* temp = *head;
	*head = (*head)->next;
	char popped = temp->key;
	free(temp);

	return popped;
}
char peek(struct Node* head){
	if(isEmpty(head)) return 0;
	return head->key;
}
//-------- End of Stack Declaration -------

// ---Pushdown Authomata-----

int isMatchingPair(char character1, char character2) { 
   if (character1 == '(' && character2 == ')') 
     return 1; 
   else if (character1 == '{' && character2 == '}') 
     return 1; 
   else if (character1 == '[' && character2 == ']') 
     return 1; 
   else if (character1 == '\"' && character2 == '\"')
     return 1;
   else if(character1 == '\'' && character2 == '\'')
     return 1;
   else
     return 0; 
} 

char missingCharacter(char ch){
                switch(ch){
                    case '{':
                        return '}';
                    case '}':
                        return '{';
                    case '[':
                        return ']';
                    case ']':
                        return '[';
                    case '(':
                        return ')';
                    case ')':
                        return '(';
                    case '\"':
                        return '\"';
                }
    return -1;
}

int lexicalAnalyzer(struct Node* stack, const char* fileName){
    FILE *fp;
	char ch;
    char missing;
    char lineCounter = 1;
    int isComment = 0;
    int unbalanced = 0;
	fp = fopen(fileName,"r");
	while((ch = fgetc(fp)) != EOF){
        if(ch == '\n'){
            isComment = 0;
            lineCounter++;
        }
        if(ch == '/'){
            switch(isComment){
                case 0:
                    isComment++;
                    break;
                case 1:
                    isComment++;
                    break;
            }
        }
		if((ch == '(' || ch == '[' || ch == '{' || ch == '\"' || ch == '\'' ) && isComment < 2){
			push(&stack, ch);
		}	
		if((ch == ')' || ch == ']' || ch == '}' || ch == '\"' || ch == '\'') && isComment < 2){
			if(isEmpty(stack)){
                missing = missingCharacter(ch);
                printf("Missing: %c on line: %d \n",missing, lineCounter);
				unbalanced = 1;
			}
			else if (!isMatchingPair(pop(&stack), ch) ) {
                missing = missingCharacter(ch);
                printf("Missing: %c on line: %d \n",missing, lineCounter);
				unbalanced = 1;
			}
		}
	}
    fclose(fp);
    if(!isEmpty(stack)){
        while(!isEmpty(stack)){
            missing = pop(&stack);
            printf("Missing %c \n",missingCharacter(missing));
        }
        return 0;
    }
	return isEmpty(stack) && unbalanced == 0;
}

// --- End of Pushdown Authomata Declaration


int main(int argc, char** argv){
    printf("Testing file: %s \n", argv[1]);
    struct Node* stack = NULL;
    if(lexicalAnalyzer(stack, argv[1])){
		printf("There are no errors, congratulations, I guess\n");
        return 0;
	}
    printf("You have syntax errors\n");
    return -1;
}
