%{
#define YYSTYPE char*
#include <stdio.h>
void yyerror(char *);
#include "y.tab.h"
%}
%%
\s*\/\*.*[^\*\/]*\*\/\s* {
    ;
}
int {
    fprintf(yyout,"TYPE: %s\n",yytext);   
    yylval = strdup(yytext);
    return TYPE;
}
char\ \* {
    fprintf(yyout,"TYPE: %s\n",yytext);
    yylval = strdup(yytext);
    return TYPE;
    
}
char\ \*\* {
    fprintf(yyout,"TYPE: %s\n",yytext);
    yylval = strdup(yytext);
    return TYPE;
}

if {
    fprintf(yyout,"IF: %s\n",yytext);
    yylval = strdup(yytext);
    return IF;
}
while {
    fprintf(yyout,"WHILE: %s\n",yytext);
    yylval = strdup(yytext);
    return WHILE;
}
else {
    fprintf(yyout,"ELSE: %s\n",yytext);
    yylval = strdup(yytext);
    return ELSE;
}
& {
    fprintf(yyout,"AND: %s\n",yytext);
    yylval = strdup(yytext);
    return AND;
}
"|" {
    fprintf(yyout,"OR: %s\n",yytext);
    yylval = strdup(yytext);
    return OR;
}
">=" {
    fprintf(yyout,"GEQ: %s\n",yytext);
    yylval = strdup(yytext);
    return GEQ;
}
"<=" {
    fprintf(yyout,"LEQ: %s\n",yytext);
    yylval = strdup(yytext);
    return LEQ;
}
"<" {
    fprintf(yyout,"LTHN: %s\n",yytext);
    yylval = strdup(yytext);
    return LTHN;
}
">" {
    fprintf(yyout,"GRTHN: %s\n",yytext);
    yylval = strdup(yytext);
    return GRTHN;
}
return {
    fprintf(yyout,"RETURN: %s\n",yytext);
    yylval = strdup(yytext);
    return RETURN;
}
[0-9]+ {
    fprintf(yyout,"LIT: %s\n",yytext);
    yylval = strdup(yytext);
    return LIT;
}

\+ {
    fprintf(yyout,"PLUS: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
- {
    fprintf(yyout,"SUB: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
\/ {
    fprintf(yyout,"DIV: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
\* {
    fprintf(yyout,"MUL: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
; {
    fprintf(yyout,"SEMI: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
= {
    fprintf(yyout,"ASSIGN: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
== {
    fprintf(yyout,"EQS: %s\n",yytext);
    yylval = strdup(yytext);
    return EQS;
}
!= {
    fprintf(yyout,"NEQS: %s\n",yytext);
    yylval = strdup(yytext);
    return NEQS;
}
\( {
    fprintf(yyout,"OPAREN: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
\) {
    fprintf(yyout,"CPAREN: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
[a-zA-Z_][a-zA-Z0-9_]* {
    fprintf(yyout,"ID: %s\n",yytext);
    yylval = strdup(yytext);
    return ID;
}
\".*\" {
    fprintf(yyout,"LIT: %s\n",yytext);
    yylval = strdup(yytext);
    return LIT;
}
\{ {
    fprintf(yyout,"OCURL: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
\} {
    fprintf(yyout,"CCURL: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
\[ {
    fprintf(yyout,"OBLK: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}
\] {
    fprintf(yyout,"CBLK: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}


" " {
    ;
}
\n {
    ;
}

, {
    fprintf(yyout,"COMMA: %s\n",yytext);
    yylval = strdup(yytext);
    return *yytext;
}

. {
    
    yyerror("Unrecognized input");
}


%%

