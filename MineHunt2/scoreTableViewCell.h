//
//  scoreTableViewCell.h
//  MineHunt2
//
//  Created by Jonathan French on 24/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblRank;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end
