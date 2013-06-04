//
//  NonoColorChooser.h
//  nono
//
//  Created by Charles Francoise on 6/3/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NonoColorChooser : UIControl

@property (nonatomic, readonly) UIColor* selectedColor;

- (id)initWithColors:(NSArray*)colors;

- (void)setColors:(NSArray*)colors;

@end
