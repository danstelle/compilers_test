#pragma once

#include "ExprNode.h"

class IntExprNode : public ExprNode
{
    public:
        IntExprNode(int value) : mValue(value)
        {}
        int GetValue()
        {
            return mValue;
        }
        string Display()
        {
            return std::to_string(mValue);
        }
    
    private:
        int mValue;
};