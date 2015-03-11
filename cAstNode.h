/***********************************************
 * Author: Daniel Stelle
 *  
 * Purpose: To be the root node for all nodes
 *          and require a toString function
 *          for all nodes.
 ***********************************************/
#ifndef CASTNODE_H
#define CASTNODE_H

#include <string>
#include <iostream>

using std::string;

class cAstNode
{
    public:
        virtual string Display() = 0;
};
#endif