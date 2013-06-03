//
//  NonoColorChooserViewController.m
//  nono
//
//  Created by Charles Francoise on 6/3/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import "NonoColorChooserViewController.h"

#import "NonoGrid.h"

#import "NonoUtilities.h"

static const CGFloat X_MARGIN = 2.0f;
static const CGFloat Y_MARGIN = 2.0f;
static const CGFloat Y_SPACE = 4.0f;
static const CGFloat BUTTON_WIDTH = 40.0f;

@interface NonoColorChooserViewController ()

@property (nonatomic, retain) NSArray* colors;

@end

@implementation NonoColorChooserViewController

- (id)initWithColors:(NSArray*) colors
{
    self = [super initWithNibName:@"NonoColorChooserViewController" bundle:nil];
    if (self)
    {
        _colors = [colors retain];
    }
    return self;
}

- (void)dealloc
{
    [_colors release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect frame = CGRectMake(X_MARGIN, Y_MARGIN, BUTTON_WIDTH, BUTTON_WIDTH);
    for (NSData* data in self.colors)
    {
        NonoColor color;
        [data getBytes:&color length:sizeof(NonoColor)];
        
        UIButton* colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        colorButton.backgroundColor = [NonoUtilities colorWithNonoColor:color];
        [colorButton addTarget:self action:@selector(colorTouched:) forControlEvents:UIControlEventTouchDown];
        
        frame.origin.y += BUTTON_WIDTH + Y_SPACE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor*)selectedColor
{
    for (UIButton* colorButton in self.view.subviews)
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
    for (UIButton* button in self.view.subviews)
    {
        button.selected = NO;
    }
    colorButton.selected = YES;
}

@end
