/***********************************************
 * Author: Daniel Stelle
 *  
 * Purpose: To handle the different symbols that
 *          lang.l finds.
 ***********************************************/
#ifndef CSYMBOL_H
#define CSYMBOL_H

#include <iostream>
#include <string>

using std::string;

class cSymbol
{
    public:
        cSymbol(string sym)
            : mSym(sym), mSequence(++symbolCount)
        {}
        string toString()
        {
            return "sym: " + mSym + " " + std::to_string(mSequence);
        }
        int GetSymCount()
        {
            return symbolCount;
        }
        string GetName()
        {
            return mSym;
        }
        
    protected:
        string mSym;
        int mSequence;
        static int symbolCount;
};
#endif