%{
// lang lexer definition file
//
// Author: Daniel Stelle daniel.stelle@oit.edu

#include "lex.h"

#define RETURN(a) return Return(a);
static int Return(int val);
%}

%option noyywrap
%option noinput
%option nounput
%option yylineno


    /* definitions go here */
operators           [+\-*/]
identifier          [a-z]+
integer_const       -?[0-9]+
whitespace          [' '\t\n]+
comment             "//".*$
junk                .

%%

    // token definitions go here.
"print"                     RETURN(PRINT);
"return"                    RETURN(RETURN_TOK);
"end"                       RETURN(END);
{identifier}                {
                                yylval.symbol = symbolTableRoot->FullLookup(yytext);
                               
                                if (yylval.symbol == nullptr)
                                {
                                    yylval.symbol = new cSymbol(yytext);
                                }
                                
                                RETURN(IDENTIFIER);
                            }

{operators}                 RETURN(yytext[0]);
{integer_const}             {
                                yylval.int_val = atoi(yytext);
                                RETURN(INT_VAL);
                            }
{whitespace}                //{};
{comment}                   //{};
{junk}                      RETURN(JUNK_TOKEN);

%%

// This function allows us to do extra processing on each token
static int Return(int val)
{
    //printf("Scanned '%s': %d\n", yytext, val);
    return val;
}
