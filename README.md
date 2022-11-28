## Parser for Tiny C (a subset of C language)
- Developed a tiny C parser using parsing technique and avoiding anomalies. 
- The tools used for development were Flex and Bison. 

cucu.l
    - cucu.l tokenizes each matching string.
    - please take care when writing writing pointer to char i.e. "char *" is correct, 
      while "char*" is not allowed. This is strictly in complaince as written in problem statement.
    - since there are only 3 datatypes allowed (int, char *. char **), using datatypes like char or void isn't allowed. using datatypes other than allowed datatypes will give an error.
    - error will be reported in lexer.txt as well as in terminal.

cucu.y
    - function defination is in format similar to that of in C.
    - function declaration is in format similar to that of in C.
    - if statements and while statements is allowed.
    - output is printed in "parser.txt".
    - during parsing of an expression, format of printing is "similar to" postfix.
    - parsing of bracket is a little tricky , but can be done by parsing from left to right. 
    - similarly parsing of if-else , while etc. is also a little tricky.
    - content within function is above function name.

how to run?
run following commands in order. 
    - flex cucu.l
    - bison -dy cucu.y
    - gcc y.tab.c lex.yy.c -o cucu.exe
    - ./cucu.exe Sample1.cu 
        -should give proper output in lexer.txt and parser.txt
    - ./cucu.exe Sample2.cu 
        -should give an error.



