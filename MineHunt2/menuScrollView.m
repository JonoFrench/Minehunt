//
//  menuScrollView.m
//  MineHunt2
//
//  Created by Jonathan French on 23/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import "menuScrollView.h"

@interface menuScrollView()

@property (nonatomic,strong) NSMutableArray *scores;

@end

@implementation menuScrollView



-(instancetype)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {

    }
    return self;
}

-(void)setUp
{
    self.scores = [[[highScores alloc]init]getHighScores:self.gameType];
    NSLog(@"Scores %@",self.scores);
    self.tblScores.delegate=self;
    self.tblScores.dataSource=self;
    [self.tblScores reloadData];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    highScore *score = [self.scores objectAtIndex:indexPath.row];
    int sec = score.gametime %60;
    int min = score.gametime /60;
    [cell.textLabel setText:[NSString stringWithFormat:@"%02ld: %@ %02d:%02d",(long)indexPath.row+1,score.gamedate,min,sec]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}



@end
