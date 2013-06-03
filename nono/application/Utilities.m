//
//  Utilities.m
//  nono
//
//  Created by Charles Francoise on 6/2/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (UIColor*)colorWithNonoColor:(NonoColor)nonoColor
{
    if (nncEqual(nonoColor, nncEmpty()))
    {
        return [UIColor colorWithRed:0.0f
                               green:0.0f
                                blue:0.0f
                               alpha:0.0f];
    }
    else
    {
        return [UIColor colorWithRed:nonoColor.r / 255.0f
                               green:nonoColor.g / 255.0f
                                blue:nonoColor.b / 255.0f
                               alpha:1.0f];
    }
}

+ (NonoColor)nonoColorWithColor:(UIColor*)color
{
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    if (a == 0.0f)
    {
        return nncEmpty();
    }
    else
    {
        return nnc(r * 255, g * 255, b * 255);
    }
}

@end
