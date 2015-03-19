//
//  globalSettings.h
//  MineHunt
//
//  Created by Jonathan French on 24/05/2012.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "minehunt.h"
//#import "highScore.h"


@interface globalSettings : NSObject

+(int)getNumberofBombs;

+(void)setNumberofBombs:(int)bombs;


+(int)getNumberofColumns;

+(void)setNumberofColumns:(int)cols;

+(int)getNumberofRows;

+(void)setNumberofRows:(int)rows;

+(int)getTileSize;

+(int)getImageSize;
//+(void)setTileSize:(int)rows;

+(int)getWindowWidth;

+(void)setWindowWidth:(int)width;

+(int)getWindowHeight;

+(void)setWindowHeight:(int)height;

+ (long**) Make2DIntArray:(int)row col:(int) col;

+(int)getPlayMode;

+(void)setPlayMode:(int)mode;

+(void)timerTick;
+(void)timerReset;
+(int)getTimerTime;

+(NSMutableArray*)getHighScores;
+(void)newScore;

+(UIImage *)getBlankTile;
+(UIImage *)getNumberTile:(int)numBombs;
+(UIImage *)getFlagTile;
+(UIImage *)getExplosionTile;
+(UIImage *)getQuestionTile;
+(UIImage *)getMineTile;
+(UIImage *)getEmptyTile;
+(UIImage *)getLetterTile:(NSString*)letter;

@end
