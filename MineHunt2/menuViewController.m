//
//  menuViewController.m
//  MineHunt2
//
//  Created by Jonathan French on 18/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import "menuViewController.h"
#import "GameViewController.h"
#import "menuScrollView.h"
#import "highScores.h"


@interface menuViewController ()

@property (nonatomic) int gameType;

@end

@implementation menuViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.menuScroll.delegate = self;
    self.gameType = 0;


}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    for (int i=0; i<3; i++) {
        CGRect frame;
        frame.origin.x = self.menuScroll.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.menuScroll.frame.size;
        menuScrollView* subview;
        subview = [[[NSBundle mainBundle]loadNibNamed:@"menuScrollView" owner:self options:nil]firstObject];
        
        [subview setUp];
        [subview setGameType:i];

        switch (i) {
            case 0:
                [subview.lblPage setText:@"Easy Game 8*8 10 Bombs"];
                break;
            case 1:
                [subview.lblPage setText:@"Meduim Game 10*10 12 Bombs"];
                break;
            case 2:
                [subview.lblPage setText:@"Hard Game 16*16 20 Bombs"];
                break;
            default:
                break;
        }
        

        [subview setFrame:frame];
        
        [subview layoutIfNeeded];
        [self.menuScroll addSubview:subview];
        [self.menuScroll layoutIfNeeded];
    }
    
    self.menuScroll.userInteractionEnabled= YES;
    self.menuScroll.contentSize = CGSizeMake(self.menuScroll.frame.size.width * 3, self.menuScroll.frame.size.height);
       [self.menuScroll layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (IBAction)actPlay:(id)sender {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.p = [sb instantiateViewControllerWithIdentifier:@"gameViewController"];
    self.p.gameType = self.gameType;
    [self.navigationController pushViewController:_p animated:YES];
}

#pragma mark - Scroll Delegates

// no vertical scrolling please
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
}

//get the game number of the page
-(void)scrollViewDidEndDecelerating:(UIScrollView*)sender{
    CGRect frame  = [[UIScreen mainScreen]applicationFrame];
    float roundedValue = round(sender.contentOffset.x /frame.size.width);
    self.gameType =(int)roundedValue;
}




@end
