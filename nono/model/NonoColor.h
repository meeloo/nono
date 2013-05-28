//
//  NonoColor.h
//  nono
//
//  Created by Charles Francoise on 5/28/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

typedef uint8_t nncByte;

typedef struct
{
    nncByte r;
    nncByte g;
    nncByte b;
    BOOL empty;
}
NonoColor;

static inline NonoColor nncEmpty()
{
    NonoColor emptyColor = {0,0,0,YES};
    return emptyColor;
}

static inline NonoColor nnc(nncByte red, nncByte green, nncByte blue)
{
    NonoColor color = {red, green, blue, NO};
    return color;
}

static inline BOOL nncEqual(NonoColor lColor, NonoColor rColor)
{
    if (lColor.empty && rColor.empty)
    {
        return YES;
    }
    else if (rColor.empty)
    {
        return NO;
    }
    else if (lColor.empty)
    {
        return NO;
    }
    else
    {
        return (lColor.r == rColor.r
                && lColor.g == rColor.g
                && lColor.b == rColor.b);
    }
}