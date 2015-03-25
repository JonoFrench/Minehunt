//
//  menuScrollView.m
//  MineHunt2
//
//  Created by Jonathan French on 23/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import "menuScrollView.h"
#import "scoreTableViewCell.h"

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
    [self.tblScores registerNib:[UINib nibWithNibName:@"scoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"scoreCell"];
    self.scores = [[[highScores alloc]init]getHighScores:self.gameType];
    NSLog(@"Scores %@",self.scores);
    self.tblScores.delegate=self;
    self.tblScores.dataSource=self;
    [self.tblScores reloadData];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell");
    scoreTableViewCell *cell = [self.tblScores dequeueReusableCellWithIdentifier:@"scoreCell" forIndexPath:indexPath];
    highScore *score = [self.scores objectAtIndex:indexPath.row];
    int sec = score.gametime %60;
    int min = score.gametime /60;
    [cell.lblRank setText:[NSString stringWithFormat:@"%02ld",(long)indexPath.row+1]];
    [cell.lblDate setText:[NSString stringWithFormat:@"%@",score.gamedate]];
    [cell.lblTime setText:[NSString stringWithFormat:@"%02d:%02d",min,sec]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int heightDiv = 10;
    if (self.tblScores.frame.size.height/10 <40) {
        heightDiv = 5;
    }
    return self.tblScores.frame.size.height/heightDiv;
}

@end
