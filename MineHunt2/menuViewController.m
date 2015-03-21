//
//  menuViewController.m
//  MineHunt2
//
//  Created by Jonathan French on 18/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import "menuViewController.h"
#import "GameViewController.h"

@interface menuViewController ()

@end

@implementation menuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (IBAction)actPlay:(id)sender {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _p = [sb instantiateViewControllerWithIdentifier:@"gameViewController"];
    [self.navigationController pushViewController:_p animated:YES];
}

@end
