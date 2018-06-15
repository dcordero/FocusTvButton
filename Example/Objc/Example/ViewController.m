//
//  ViewController.m
//  Example
//
//  Created by David Cordero on 13.06.18.
//  Copyright © 2018 David Cordero. All rights reserved.
//

#import "ViewController.h"

@import FocusTvButton;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FocusTvButton *button = [[FocusTvButton alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    button.focusedBackgroundColor = UIColor.greenColor;
    button.normalBackgroundColor = UIColor.lightGrayColor;
    button.cornerRadius = 0.5 * button.bounds.size.width;
    [button setTitle:@"Button" forState:UIControlStateNormal];

    [self.view addSubview:button];
}

@end
