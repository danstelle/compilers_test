#pragma once

#include "cAstNode.h"

class ExprNode : public cAstNode
{
    public:
        virtual int GetValue() = 0;
        virtual string Display() = 0;
    
    private:
        
};