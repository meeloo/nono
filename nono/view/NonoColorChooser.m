//
//  NonoColorChooser.m
//  nono
//
//  Created by Charles Francoise on 6/3/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoColorChooser.h"

#import "NonoGrid.h"

#import "NonoUtilities.h"

static const CGFloat X_MARGIN = 2.0f;
static const CGFloat Y_MARGIN = 2.0f;
static const CGFloat Y_SPACE = 4.0f;
static const CGFloat BUTTON_WIDTH = 40.0f;

@interface NonoColorChooser ()

@property (nonatomic, copy) NSArray* colors;

@end

@implementation NonoColorChooser

- (id)initWithColors:(NSArray*)colors
{
    self = [super init];
    if (self)
    {
        [self setColors:colors];
        [self setupButtons];
    }
    return self;
}

- (void)dealloc
{
    [_colors release];
    [super dealloc];
}

- (void)setupButtons
{
    for (UIView* subview in self.subviews)
    {
        [subview removeFromSuperview];
    }
    
    CGRect frame = CGRectMake(X_MARGIN, Y_MARGIN, BUTTON_WIDTH, BUTTON_WIDTH);
    for (NSData* data in self.colors)
    {
        NonoColor color;
        [data getBytes:&color length:sizeof(NonoColor)];
        
        UIButton* colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        colorButton.frame = frame;
        colorButton.backgroundColor = [NonoUtilities colorWithNonoColor:color];
        [self addSubview:colorButton];
        [colorButton addTarget:self action:@selector(colorTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        frame.origin.x += BUTTON_WIDTH + Y_SPACE;
    }
}

- (UIColor*)selectedColor
{
    for (UIButton* colorButton in self.subviews)
    {
        if (colorButton.selected)
        {
            return colorButton.backgroundColor;
        }
    }
    
    return nil;
}

- (void)colorTouched:(UIButton*)colorButton
{
    for (UIButton* button in self.subviews)
    {
        button.selected = NO;
    }
    colorButton.selected = YES;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setColors:(NSArray *)colors
{
    if (_colors != nil)
    {
        [_colors release];
    }
    _colors = [colors copy];
    
    [self setupButtons];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = Y_MARGIN + Y_MARGIN + BUTTON_WIDTH;
    [super setFrame:frame];
}

@end
