//
//  menuViewController.h
//  MineHunt2
//
//  Created by Jonathan French on 18/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface menuViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong,nonatomic) GameViewController *p;
- (IBAction)actPlay:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *menuScroll;

@end
