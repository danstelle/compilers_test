#pragma once

#include "ExprNode.h"

class OpNode : public ExprNode
{
    public:
        OpNode(ExprNode * expr1, ExprNode * expr2, char op)
            : mExpr1(expr1), mExpr2(expr2), mOperator(op)
        {
            //if (mOperator)
        }
        string Display()
        {
            return "OpNode";
        }
        int GetValue()
        {
            return 0;
        }
    
    private:
        ExprNode * mExpr1;
        ExprNode * mExpr2;
        char       mOperator;
};