//
//  globalSettings.m
//  MineHunt
//
//  Created by Jonathan French on 24/05/2012.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "globalSettings.h"
#import "MineHuntImages.h"

@implementation globalSettings

int _bombNumber;
int _rows;
int _cols;
int _tilesize;
int _windowWidth;
int _windowHeight;
int _playmode;
int _timertime;
NSMutableArray *ScoreArray;

#pragma mark Initialization

+ (void)initialize
{
    NSLog(@"Init");
}


+(UIImage *)getBlankTile
{
    return [MineHuntImages imageOfBlankWithFrame:CGRectMake(0, 0,[self getTileSize],[self getTileSize])];
}

+(UIImage *)getNumberTile:(int)numBombs
{

    return [MineHuntImages imageOfBombCountWithFrame:CGRectMake(0, 0,[self getTileSize],[self getTileSize]) numBombs:[NSString stringWithFormat:@"%d",numBombs]];
}

+(UIImage *)getLetterTile:(NSString*)letter
{
    
    return [MineHuntImages imageOfBombCountWithFrame:CGRectMake(0, 0,[self getTileSize],[self getTileSize]) numBombs:letter];
}


+(UIImage *)getQuestionTile
{
    return [MineHuntImages imageOfQuestionWithFrame:CGRectMake(0, 0,[self getTileSize],[self getTileSize])];
}

+(UIImage *)getMineTile
{
    return [MineHuntImages imageOfMineWithFrame:CGRectMake(0, 0,[self getTileSize],[self getTileSize])];
}

+(UIImage *)getExplosionTile
{
    return [MineHuntImages imageOfExplosionWithFrame:CGRectMake(0, 0,[globalSettings getTileSize],[globalSettings getTileSize])];
}

+(UIImage *)getFlagTile
{
    return [MineHuntImages imageOfFlagWithFrame:CGRectMake(0, 0,[self getTileSize],[self getTileSize])];
}

+(UIImage *)getEmptyTile
{
    return [MineHuntImages imageOfEmptyWithFrame:CGRectMake(0, 0,[self getTileSize],[self getTileSize])];
}

+(void)timerTick
{
    _timertime++;
}

+(void)timerReset
{
    _timertime = 0;
}

+(int)getTimerTime
{
    return _timertime;
}

+(int)getNumberofBombs
{
    return _bombNumber;
}

+(void)setNumberofBombs:(int)bombs
{
    _bombNumber = bombs;
}

+(int)getNumberofColumns{
    return _cols;
}

+(void)setNumberofColumns:(int)cols{
    _cols = cols;
}


+(int)getNumberofRows{
    return _rows;
}

+(void)setNumberofRows:(int)rows{
    _rows = rows;
}

+(int)getTileSize{
    return _windowWidth/_cols;
}

+(int)getImageSize{
    NSLog(@"ImageSize %f",(_windowWidth/_cols) * [[UIScreen mainScreen]scale]);
    return (_windowWidth/_cols) * [[UIScreen mainScreen]scale];

}

+(int)getWindowWidth{
    return _windowWidth;
}

+(void)setWindowWidth:(int)width{
    _windowWidth = width;
}

+(int)getWindowHeight{
    return _windowHeight;
}

+(void)setWindowHeight:(int)height{
    _windowHeight = height;
}


+ (long**) Make2DIntArray:(int)row col:(int) col
{
    long **theArray;
    theArray = (long **) malloc(row * sizeof(long*));
    for (int i = 0;i < row;i++)
    {
        theArray[i] = (long*) malloc(col*sizeof(long));
    }
    return theArray;
}

+(int)getPlayMode
{
    return _playmode;
}

+(void)setPlayMode:(int)mode
{
    _playmode = mode;
}


//+(NSArray*)getHighScores
//{
//    ScoreArray = [[NSMutableArray alloc]init];
//    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
//    //check if the object does not exist
//    if([standardDefaults objectForKey:@"scores"]!=nil)
//    {
//        NSData *data= [standardDefaults objectForKey:@"scores"];
//        
//        ScoreArray = (NSMutableArray*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    }
//    else {
//        // create a new emptyish highscore table
//        for(int i=0;i<10;i++)
//        {
//            highScore *hs = [[highScore alloc]init];
//            [ScoreArray addObject:hs];
//        }
//        [self SaveHighScores];
//    }
//    return ScoreArray;
//}
//
//+(void)SaveHighScores
//{
//    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
//    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:ScoreArray];
//    [standardDefaults setObject:myEncodedObject forKey:@"scores"];
//    [standardDefaults synchronize];
//    
//}
//
//+(void)newScore
//{
//    ScoreArray = [self getHighScores];
//    for (int i=0;i<10;i++){
//        highScore *hs = [ScoreArray objectAtIndex:i];
//        if(_timertime <= [hs gametime ])
//           {
//               //new high score
//               highScore *newhs = [[highScore alloc]init];
//               [newhs setGametime:_timertime];
//               NSDate *date = [NSDate date];
//               NSDateFormatter * f =[[NSDateFormatter alloc]init];
//               [f setDateFormat:@"dd-MM-yyyy"];
//               [newhs setGamedate:[f stringFromDate:date]];
//               [ScoreArray insertObject:newhs atIndex:i];
//               [ScoreArray removeLastObject];
//               [self SaveHighScores];
//               return;
//           }
//        
//    }
//    
//}

@end
