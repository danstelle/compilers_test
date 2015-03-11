#include "cSymbol.h"
#include "cSymbolTable.h"
#include "cAstNode.h"
#include "IntExprNode.h"
#include "ExprNode.h"
#include "StmtNode.h"
#include "PrintNode.h"
#include "StoreNode.h"
#include "OpNode.h"
#include "langparse.h"

extern char * yytext;
extern int yylineno;
extern cSymbolTable * symbolTableRoot;
extern FILE *yyin;
extern int yyparse();
extern int yylex();
extern int yynerrs;