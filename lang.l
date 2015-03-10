%{
// lang lexer definition file
//
// Author: Daniel Stelle daniel.stelle@oit.edu

#include "lex.h"
//#include "langparse.h"


#define RETURN(a) return Return(a);
static int Return(int val);
%}

%option noyywrap
%option noinput
%option nounput
%option yylineno


    /* definitions go here */
punctuation         [\.\,\;\[\]\{\}\(\)]
operators           [+\-*/%=!<]
identifier          [a-zA-Z][a-zA-Z0-9_]*
integer_const       -?[0-9]+
float_const         -?[0-9]+[\.][0-9]+
whitespace          [' '\t\n]+
comment             "//".*$
junk                .

%%

    // token definitions go here.
"if"                        RETURN(IF);
"else"                      RETURN(ELSE);
"while"                     RETURN(WHILE);
"print"                     RETURN(PRINT);
"scan"                      RETURN(SCAN);
"struct"                    RETURN(STRUCT);
"return"                    RETURN(RETURN_TOK);
"array"                     RETURN(ARRAY);
{punctuation}               RETURN(yytext[0]);
{identifier}                {
                                yylval.symbol = symbolTableRoot->FullLookup(yytext);
                               
                                if (yylval.symbol != nullptr)
                                {
                                    if(yylval.symbol->IsType())
                                    {
                                        RETURN(TYPE_ID);
                                    }
                                }
                                else
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
{float_const}               {
                                yylval.float_val = atof(yytext);
                                RETURN(FLOAT_VAL);
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
