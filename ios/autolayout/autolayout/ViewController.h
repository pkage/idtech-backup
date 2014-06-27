//
//  ViewController.h
//  autolayout
//
//  Created by iD Student on 6/18/14.
//  Copyright (c) 2014 pk inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

- (IBAction)button1press:(id)sender;
- (IBAction)button2press:(id)sender;
@end
