%{
#include<stdio.h>
#include<string.h>  
#include <stdbool.h>
//variable and function declaration and initialization
char **unique;// Array of unique words from input stream 
bool check_existence(char*, char**, int);// function to check if a word exists in the aray 
int i = 0;//counter to count unique words

//function definition
bool check_existence(char *word, char **unique, int unique_length){
	
	int i;
//loop through the list to check if the matched word is in the list
	for(i = 0; i< unique_length; i++){	
		if(strcmp(word, unique[i]) == false){
			return false;
		}
	}
//no match found
	return true;
}
%}
%%

[a-zA-Z0-9]+  {//action
		if(check_existence(yytext,unique, i)){//check if word already exists
			unique = (char**)realloc(unique, (i+1)*sizeof(*unique));//expanding array size 
			//allocate memory in word list for new word
			
			unique[i] = (char*)malloc(sizeof(yytext));
			
			//copy new word into word list

			strcpy(unique[i], yytext);
			i++;


		}
	}
. ;
\n ;
%%


int main(void)
{
    yyin =fopen("words.txt","r");// getting the input stream from a file
    yylex();
    printf("\n Number of unique words is: %d\n", i);
free (unique);
}

int yywrap()

{
    return(1);

}

