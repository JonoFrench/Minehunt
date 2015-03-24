//
//  menuScrollView.h
//  MineHunt2
//
//  Created by Jonathan French on 23/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "highScores.h"

@interface menuScrollView : UIView <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblPage;
@property (weak, nonatomic) IBOutlet UITableView *tblScores;
@property (nonatomic) int gameType;
-(void)setUp;

@end
