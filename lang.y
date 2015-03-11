/***********************************
*lang.y
*
*Daniel Stelle
*daniel.stelle@oit.edu
************************************/

%{
#include <iostream>
#include <map>
#include "lex.h"
%}

%locations

%union{
    int             int_val;
    cAstNode*       ast_node;
    cSymbol*        symbol;
    ExprNode*       expr_node;
    StmtNode*       stmt_node;
    StoreNode*      store_node;
    }

%{
    int yyerror(const char *msg);

    void *yyast_root;
%}

%start  program

%token <symbol>     IDENTIFIER
%token <int_val>    INT_VAL

%token  PRINT
%token  RETURN_TOK
%token  END
%token  JUNK_TOKEN

%type <ast_node> program
%type <stmt_node> stmt
%type <expr_node> expression

%%
program: stmt                           {
                                            $$ = $1;
                                            yyast_root = $$;
                                            
                                            if (yynerrs == 0)
                                                YYACCEPT;
                                            else
                                                YYABORT;
                                        }

stmt:    expression IDENTIFIER ';'      {
                                            if (symbolTableRoot->CurLookup($2->GetName()) == nullptr)
                                            {
                                                $2 = symbolTableRoot->Insert($2);
                                                $$ = new StmtNode();
                                            }
                                        }
       | expression PRINT ';'           { $$ = new PrintNode($1); }
       | END                            {}
       | error ';'                      {}
    
expression: INT_VAL                     { $$ = new IntExprNode($1); }
          | IDENTIFIER                  {  }
          | expression expression '+'   { $$ = new OpNode($1, $2, '+'); }
          | expression expression '-'   { $$ = new OpNode($1, $2, '-'); }
          | expression expression '*'   { $$ = new OpNode($1, $2, '*'); }
          | expression expression '/'   { $$ = new OpNode($1, $2, '/'); }
          

%%

int yyerror(const char *msg)
{
    std::cerr << "ERROR: " << msg << " at symbol \'"
        << yytext << "\' on line " << yylineno << "\n";

    return 0;
}

void semantic_error(std::string msg)
{
    std::cout << "ERROR: " << msg << " on line " << yylineno << std::endl;
    
    yynerrs++;
}