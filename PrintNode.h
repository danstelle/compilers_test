#pragma once

#include "StmtNode.h"
#include "ExprNode.h"

class PrintNode : public StmtNode
{
    public:
        PrintNode(ExprNode * expr) : mExpr(expr)
        {}
        string Display()
        {
            return std::to_string(mExpr->GetValue());
        }
        
    private:
        ExprNode * mExpr;
};