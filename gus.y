%{
	#include<stdio.h>
    	#include<stdlib.h>
	#include<string.h>
	extern int yylineno;
	extern FILE *yyin, *yyout;
	char symb[30][20]={};
	int size=0;
	int scanId(char*);
	void addId(char*);
%}
%union{
	int _int;
	char *str;
}
%token INT FLOAT CHAR DOUBLE VOID CHARLIT
%token WHILE 
%token IF ELSE 
%token STRUCT CLASS
%token <_int>NUM <str>ID
%token STRLIT COUT ENDL COUTOP
%token CIN CINOP
%type <_int>Assignment

%right '='
%left '<' '>' LE GE EQ NE LT GT
%left '+' '-' '/' '*'
%%

start:    Declaration { printf("String parsed successfully.\n");printf("%s",symb); exit(0);}
	| Function { printf("String parsed successfully.\n"); exit(0);}
	| Function start { printf("String parsed successfully.\n"); exit(0);}
	| Declaration start { printf("String parsed successfully.\n");printf("%s",symb); exit(0);}
	;

/* Declaration block */
Declaration: Type Assignment ';' 
	| Assignment ';'  
	| StructStmt ';'
	| ClassStmt ';'
	;
/* Assignment block */
Assignment: ID '=' Assignment {void addId($1);fprintf(yyout, "< %s = %d >\n", $1,$3);}
	| ID ',' Assignment 
	| NUM ',' Assignment 
	| ID '+' Assignment 
	| ID '-' Assignment 
	| ID '*' Assignment 
	| ID '/' Assignment	
	| NUM '+' Assignment {$$=$1+$3;}
	| NUM '-' Assignment {$$=$1-$3;}
	| NUM '*' Assignment {$$=$1*$3;}
	| NUM '/' Assignment {$$=$1/$3;}
	| '(' Assignment ')' {$$=$2;}
	|   ID 
	|NUM {$$=$1;}
	;
/* Function block */
Function: Type ID '(' ArgListOpt ')' CompoundStmt 
	;
ArgListOpt: ArgList
	|
	;
ArgList:  ArgList ',' Arg
	| Arg
	;
Arg:	Declaration 	
	;
CompoundStmt:	'{' StmtList '}'
	;
StmtList:	 Stmt StmtList
	|
	;
Stmt:	WhileStmt
	| Declaration
	| IfStmt
	| coutstatement ';'
	| cinstatement ';'
	| ';'
	;
/* Type Identifier block */
Type:	INT
	| FLOAT
	| CHAR
	| DOUBLE
	| VOID
	;
/* Loop Blocks */ 
WhileStmt: WHILE '(' Expr ')' Stmt  
	| WHILE '(' Expr ')' CompoundStmt 
	;
/* IfStmt Block */
IfStmt : IF '(' Expr ')'  CompoundStmt else
	;

else:  ELSE IfStmt | ELSE CompoundStmt 
	|
	;

/* Struct Statement */
StructStmt : STRUCT ID '{' Declaration '}'
	;
/* class statement */
ClassStmt: CLASS ID '{' StmtList '}'
 	;
/*Expression Block*/
Expr: Assignment oper Assignment
	;
oper: LE|GE|NE|EQ|GT|LT
coutstatement:
	COUT COUTOP STRLIT COUTOP ENDL  ;

cinstatement:
	CIN CINOP ID  ;
%%
int yywrap(){}
int scanId(char *id)
{
int i;
for(i=0;i<size;i++)
{
if(!strcmp(symb[i],id))
{
printf("they r equal\n");
}
}
}
void addId(char *id){
strcpy(symb[size],id);
size++;
}
int main(){
  

/* yyin points to the file input.txt
and opens it in read mode*/
yyin = fopen("Input.txt", "r");
  
/* yyout points to the file output.txt
and opens it in write mode*/
yyout = fopen("Output.txt", "w");
yyparse();
return 0;
}
void yyerror()
{
 printf ("error at line %d  ",yylineno);
 exit(0);
}
