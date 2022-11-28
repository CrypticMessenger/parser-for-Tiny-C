%{
#define YYSTYPE char*
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
int yylex(void);
void yyerror(char *);

FILE *file1;  
extern FILE *yyin,*yyout;

%}
%left '+' '-'
%left '*' '/'

%token TYPE ID LIT IF WHILE EQS NEQS ELSE RETURN GEQ LEQ LTHN GRTHN AND OR
%%

program: program fun_def 
    |program fun_decl
    |program var_decl
    |fun_def 
    |fun_decl
    |var_decl
    ;
fun_decl: TYPE ID '(' types ')' ';' {fprintf(file1,"func_decl: %s\n",$2);}
    | TYPE ID '(' args ')' ';' {fprintf(file1,"func_decl: %s\n",$2);}
fun_def: TYPE ID '(' args ')' '{' stmts '}' {fprintf(file1,"func_identifier: %s\n\n",$2);}
return: RETURN expr ';' {fprintf(file1," := Return \n");}
var_decl: TYPE ID ';' {fprintf(file1,"global var: %s\n",$2);}
args: args ',' TYPE ID {fprintf(file1,"argument: %s (type: %s)\n",$4,$3);} 
    |TYPE ID {fprintf(file1,"\nargument: %s (type: %s)\n",$2,$1);}
    |
    ;
types: types ',' TYPE {fprintf(file1,"type: %s\n",$3);}
    | TYPE {fprintf(file1,"\ntype: %s\n",$1);}
    ;
ids: ids ',' expr {;}
    |expr
    |
    ;
stmts: stmts stmt
    |
    ;

stmt: TYPE ID ';' {fprintf(file1,"local var:%s\n",$2);}
    | TYPE ID '=' expr ';' {fprintf(file1,"=: var:%s\n",$2);}
    | ID '=' expr ';'    {fprintf(file1,"=: var:%s\n",$1);}
    | while_stmt
    | if_stmt
    | ID '(' ids ')' ';' {fprintf(file1,"FUNCT_CALL:%s ()\n",$1);}
    | ID '=' ID '(' ids ')' ';' {fprintf(file1,"FUNCT_CALL:%s ()=:%s\n",$3,$1);}
    | TYPE ID '=' ID '(' ids ')' ';' {fprintf(file1,"FUNCT_CALL:%s ()=:%s\n",$4,$2);}
    | return
    ;

expr: logic_expr
    ;
logic_expr: eq_expr
    | logic_expr AND eq_expr {fprintf(file1,"& ");}
    | logic_expr OR eq_expr {fprintf(file1,"| ");}
    ;
eq_expr: rel_expr
    | eq_expr EQS rel_expr {fprintf(file1,"== ");}
    | eq_expr NEQS rel_expr {fprintf(file1,"!= ");}
    ;
rel_expr: add_sub_expr
    | rel_expr LTHN add_sub_expr {fprintf(file1,"< ");}
    | rel_expr GRTHN add_sub_expr {fprintf(file1,"> ");}
    | rel_expr LEQ add_sub_expr {fprintf(file1,"<= ");}
    | rel_expr GEQ add_sub_expr {fprintf(file1,">= ");}
    ;
add_sub_expr : mul_div_expr
    | add_sub_expr '+' mul_div_expr {fprintf(file1,"+ ");}
    | add_sub_expr '-' mul_div_expr {fprintf(file1,"- ");}
    ;
mul_div_expr: end_expr
    | mul_div_expr '*' end_expr {fprintf(file1,"* ");}
    | mul_div_expr '/' end_expr {fprintf(file1,"/ ");}
    ;
end_expr: LIT {fprintf(file1,"Const:%s ",$1);}
    | ID {fprintf(file1,"var:%s ",$1);}
    | '(' expr ')' {fprintf(file1," ( ) ");}
    | ID '[' expr ']' {fprintf(file1," %s[] ",$1);}
    ;

if_stmt: IF '(' expr ')' stmt {fprintf(file1,"IF_STMT:\n");}
       | IF '(' expr ')' '{' stmts '}' {fprintf(file1,"IF_STMT:\n");}
       | IF '(' expr ')' '{' stmts '}' else {fprintf(file1,"IF_STMT:\n");}
       ;
else: ELSE '{' stmts '}' {fprintf(file1,"ELSE:\n");}
while_stmt: WHILE '(' expr ')' '{' stmts '}' {fprintf(file1,"WHILE :\n");}
        ;
%%
void yyerror(char * s){
    fclose(file1);
    file1 = fopen("parser.txt","w"); 
    fprintf(file1, "Some error encountered: %s",s);
    fclose(yyout);
    yyout = fopen("lexer.txt", "w");
    fprintf(yyout, "Some error encountered: %s",s);
    fprintf(stderr,"error: %s\n",s);
}
int yywrap(){
    return 1;
}
int main(int argc, char** argv){

    file1 = fopen("parser.txt","w"); 
    
    yyin = fopen(argv[1], "r");
    yyout = fopen("lexer.txt", "w");
    yyparse();
    return 0;
}