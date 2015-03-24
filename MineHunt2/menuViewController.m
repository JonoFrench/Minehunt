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
//@property (nonatomic,strong) NSMutableArray *scores;

@end

@implementation menuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.menuScroll.delegate = self;
    self.gameType = 0;

}


-(void)viewDidLayoutSubviews
{
    for (int i=0; i<3; i++) {
        CGRect frame;
        frame.origin.x = self.menuScroll.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.menuScroll.frame.size;
        menuScrollView* subview = [[[NSBundle mainBundle]loadNibNamed:@"menuScrollView" owner:self options:nil]firstObject];
        [subview setGameType:i];
        [subview setUp];
        subview.translatesAutoresizingMaskIntoConstraints = YES;
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
        

        if(i==1)
        {
            [subview setBackgroundColor:[UIColor redColor]];
        }
        [subview setFrame:frame];

        [subview layoutIfNeeded];
        [self.menuScroll addSubview:subview];
    }
    
    self.menuScroll.contentSize = CGSizeMake(self.menuScroll.frame.size.width * 3, self.menuScroll.frame.size.height);
    self.menuScroll.userInteractionEnabled= YES;
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView*)sender{
    CGRect frame  = [[UIScreen mainScreen]applicationFrame];
    float roundedValue = round(sender.contentOffset.x /frame.size.width);
    self.gameType =(int)roundedValue;
}




@end
