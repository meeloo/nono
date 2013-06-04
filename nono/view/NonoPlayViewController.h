//
//  NonoPlayViewController.h
//  nono
//
//  Created by Charles Francoise on 6/3/13.
//  Copyright (c) 2013 Charles Francoise. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NonoGrid;
@class NonoColorChooser;

@interface NonoPlayViewController : UIViewController

@property (nonatomic, retain) IBOutlet NonoColorChooser* colorChooser;

- (id)initWithSolution:(NonoGrid*)solution;

- (IBAction)colorChanged:(NonoColorChooser*)sender;

@end
