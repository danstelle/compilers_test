/***********************************************
 * Author: Daniel Stelle
 *  
 * Purpose: Manages the various symbol tables
 ***********************************************/
#ifndef CSYMBOLTABLE_H
#define CSYMBOLTABLE_H

#include <iostream>
#include <list>
#include <map>
#include <string>
#include "cSymbol.h"

using std::list;
using std::map;
using std::string;

class cSymbolTable
{
    public:
        cSymbolTable()
        {}
        cSymbol * Insert(string str)
        {
            cSymbol * temp = CurLookup(str);
    
            if (temp != nullptr)
                return temp;
            else
            {
                temp = new cSymbol(str);
                mScope.front()->insert(std::pair<string, cSymbol*>(str, temp));
                
                return temp;
            }
        }
        cSymbol * Insert(cSymbol * in)
        {
            map<string,cSymbol*>::iterator it = mScope.front()->find(in->GetName());
    
            if(it != mScope.front()->end())
            {
                in = it->second;
            }
            else
            {
                if(FullLookup(in->GetName()) == in)
                    in = Insert(in->GetName());
                else
                    mScope.front()->insert(std::pair<string, cSymbol*>(in->GetName(), in));
            }
            
            return in;
        }
        cSymbol * FullLookup(string sym)
        {
            list<map<string,cSymbol*>*>::iterator it;
    
            for(it = mScope.begin(); it != mScope.end(); ++it)
            {
                map<string,cSymbol*>::iterator symbol = (*it)->find(sym);
                
                if(symbol != (*it)->end())
                    return symbol->second;
            }
            
            return nullptr;
        }
        cSymbol * CurLookup(string sym)
        {
            map<string, cSymbol *>::const_iterator it = mScope.front()->find(sym);
    
            if (it == mScope.front()->end())
                return nullptr;
            else
                return it->second;
        }
    
    private:
        list<map<string,cSymbol*>*> mScope;
};
#endif