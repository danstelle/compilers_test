#pragma once

#include "ExprNode.h"
#include "StmtNode.h"

class StoreNode : public StmtNode
{
    public:
        StoreNode(ExprNode * expr) : mExpr(expr)
        {}
        string Display()
        {
            return "for now";
        }
    
    private:
        ExprNode * mExpr;
};