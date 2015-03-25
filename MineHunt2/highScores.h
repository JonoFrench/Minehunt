//
//  highScores.h
//  MineHunt2
//
//  Created by Jonathan French on 21/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface highScores : NSObject


-(void)newScore: (int)timerTime type:(int)gameType;
-(NSMutableArray*)getHighScores:(int)gameType;

@end

@interface highScore : NSObject
{
    int _time;
    NSString *_date;
}
@property (nonatomic) int gametime;
@property (nonatomic,retain) NSString *gamedate;

@end
