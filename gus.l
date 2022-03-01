%{
#include"pro.tab.h"
#include<string.h>
%}
%option yylineno
let [a-zA-Z]
dig [0-9]
%%
\'({let}|{dig}|[ ])\' { fprintf(yyout, "< CHARLIT , %s >\n", yytext); return CHARLIT; }
\"({let}|{dig}|[ ])*\" { fprintf(yyout, "< STRLIT , %s >\n", yytext); return STRLIT; }
[ \t]		
[\n]			 		
[Cc][Oo][Uu][Tt] 		{ fprintf(yyout, "< KW , %s >\n", yytext); return COUT; }
[Ee][Nn][Dd][Ll]		{ fprintf(yyout, "< KW , %s >\n", yytext); return ENDL; }
[Cc][Ii][Nn] 		{ fprintf(yyout, "< KW , %s >\n", yytext); return CIN; }
[Ii][Nn][Tt]		{ fprintf(yyout, "< KW , %s >\n", yytext); return INT; }
[Ff][Ll][Oo][Aa][Tt] 		{ fprintf(yyout, "< KW , %s >\n", yytext); return FLOAT; }
[Cc][Hh][Aa][Rr] 		{ fprintf(yyout, "< KW , %s >\n", yytext); return CHAR; }
[Vv][Oo][Ii][Dd] 		{ fprintf(yyout, "< KW , %s >\n", yytext); return VOID; }
[Dd][Oo][Uu][Bb][Ll][Ee] 		{ fprintf(yyout, "< KW , %s >\n", yytext); return DOUBLE; }
[Ww][Hh][Ii][Ll][Ee]		{ fprintf(yyout, "< KW , %s >\n", yytext); return WHILE; }
[Ii][Ff]		{ fprintf(yyout, "< KW , %s >\n", yytext); return IF; }
[Ee][Ll][Ss][Ee]		{ fprintf(yyout, "< KW , %s >\n", yytext); return ELSE; }
[Ss][Tt][Rr][Uu][Cc][Tt] 		{ fprintf(yyout, "< KW , %s >\n", yytext); return STRUCT; }
[Cc][Ll][Aa][Ss][Ss] 		{ fprintf(yyout, "< KW , %s >\n", yytext); return CLASS; }
{dig}+ {fprintf(yyout, "< INTLIT , %s >\n", yytext);yylval._int=atoi(yytext); return NUM; }
{let}({let}|{dig})* {fprintf(yyout, "< ID , %s >\n", yytext);yylval.str=strdup(yytext); return ID; }
"<<"	{ fprintf(yyout, "< INSOP , %s >\n", yytext); return COUTOP; }
">>" 	{ fprintf(yyout, "< EXTROP , %s >\n", yytext); return CINOP; }
"="	{ fprintf(yyout, "< OP , %s >\n", yytext); return '='; }
"<="    	{ fprintf(yyout, "< OP , %s >\n", yytext); return LE; }
">="    	{ fprintf(yyout, "< OP , %s >\n", yytext); return GE; }
"=="    	{ fprintf(yyout, "< OP , %s >\n", yytext); return EQ; }
"!="    	{ fprintf(yyout, "< OP , %s >\n", yytext); return NE; }
">"	{ fprintf(yyout, "< OP , %s >\n", yytext); return GT; }
"<"	{ fprintf(yyout, "< OP , %s >\n", yytext); return LT; }
"+"	{ fprintf(yyout, "< OP , %s >\n", yytext); return '+'; }
"-"	{ fprintf(yyout, "< OP , %s >\n", yytext); return '-'; }
"/"	{ fprintf(yyout, "< OP , %s >\n", yytext); return '/'; }
"*"	{ fprintf(yyout, "< OP , %s >\n", yytext); return '*'; }
"["	{ fprintf(yyout, "< PUNC , %s >\n", yytext); return '['; }
"{"	{ fprintf(yyout, "< PUNC , %s >\n", yytext); return '{'; }
"("	{ fprintf(yyout, "< PUNC , %s >\n", yytext); return '('; }
")"	{ fprintf(yyout, "< PUNC , %s >\n", yytext); return ')'; }
"}"	{ fprintf(yyout, "< PUNC , %s >\n", yytext); return '}'; }
"]"	{ fprintf(yyout, "< PUNC , %s >\n", yytext); return ']'; }
";"	{ fprintf(yyout, "< PUNC , %s >\n", yytext); return ';'; }
","	{ fprintf(yyout, "< PUNC , %s >\n", yytext); return ','; }
\/\/.* 	;
\/\*(.*\n)*.*\*\/ ;
.       return yytext[0];
%%

