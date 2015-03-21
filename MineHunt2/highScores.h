//
//  highScores.h
//  MineHunt2
//
//  Created by Jonathan French on 21/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface highScores : NSObject

@property (strong,nonatomic) NSMutableArray *scoreArray;

-(void)newScore: (int)timerTime;
-(NSMutableArray*)getHighScores;

@end

@interface highScore : NSObject
{
    
    int _time;
    NSString *_date;
    
    
}
@property (nonatomic) int gametime;
@property (nonatomic,retain) NSString *gamedate;

@end
