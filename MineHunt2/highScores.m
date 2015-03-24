//
//  highScores.m
//  MineHunt2
//
//  Created by Jonathan French on 21/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import "highScores.h"

@interface highScores()

@property (strong,nonatomic) NSMutableArray *scoreArray;

@end

@implementation highScores


-(id)init
{
   self = [super init];
    if(self)
    {
//        [self getHighScores];
    }
    
    return self;
}

-(void)SaveHighScores:(int)gameType
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:_scoreArray];
    NSString *keyName = [NSString stringWithFormat:@"scores%d",gameType];
    [standardDefaults setObject:myEncodedObject forKey:keyName];
    [standardDefaults synchronize];

}

-(void)newScore: (int)timerTime type:(int)gameType
{
    _scoreArray = [self getHighScores: gameType];
    for (int i=0;i<10;i++){
        highScore *hs = [_scoreArray objectAtIndex:i];
        if(timerTime <= [hs gametime ])
           {
               //new high score
               highScore *newhs = [[highScore alloc]init];
               [newhs setGametime:timerTime];
               NSDate *date = [NSDate date];
               NSDateFormatter * f =[[NSDateFormatter alloc]init];
               [f setDateFormat:@"dd-MM-yyyy"];
               [newhs setGamedate:[f stringFromDate:date]];
               [_scoreArray insertObject:newhs atIndex:i];
               [_scoreArray removeLastObject];
               [self SaveHighScores:gameType];
               return;
           }

    }

}


-(NSMutableArray*)getHighScores: (int)gameType
{
    _scoreArray = [[NSMutableArray alloc]init];
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    //check if the object does not exist
    NSString *keyName = [NSString stringWithFormat:@"scores%d",gameType];
    if([standardDefaults objectForKey:keyName]!=nil)
    {
        NSData *data= [standardDefaults objectForKey:keyName];

        _scoreArray = (NSMutableArray*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    else {
        // create a new emptyish highscore table
        for(int i=0;i<10;i++)
        {
            highScore *hs = [[highScore alloc]init];
            NSDate *date = [NSDate date];
            NSDateFormatter * f =[[NSDateFormatter alloc]init];
            [f setDateFormat:@"dd-MM-yyyy"];
            [hs setGamedate:[f stringFromDate:date]];
            [hs setGametime:3600];
            [_scoreArray addObject:hs];
        }
        [self SaveHighScores:gameType];
    }
    return _scoreArray;
}


@end


@implementation highScore

-(highScore*)init
{
    
    if ((self = [super init]))
    {
        _time = 3600;
        _date = @"01-01-2000";
    }
    return self;
    
}


-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInt:self.gametime forKey:@"gametime"];
    [encoder encodeObject:self.gamedate forKey:@"gamedate"];
    
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init]))
    {
        self.gametime = [decoder decodeIntForKey:@"gametime"];
        self.gamedate = [decoder decodeObjectForKey:@"gamedate"];
    }
    return self;
}

@end



