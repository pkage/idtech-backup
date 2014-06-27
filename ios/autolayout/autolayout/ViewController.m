//
//  ViewController.m
//  autolayout
//
//  Created by iD Student on 6/18/14.
//  Copyright (c) 2014 pk inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button1press:(id)sender {
	[self.button1 setTitle:@"ridiculously long title" forState:UIControlStateNormal]; // change button title
}

- (IBAction)button2press:(id)sender {
	[self.button2 setTitle:@"another ridiculously long title" forState:UIControlStateNormal]; // change button title
}
@end
