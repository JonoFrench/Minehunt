//
//  GameScene.h
//  MineHunt2
//

//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "gameButton.h"

@interface GameScene : SKScene

@property (nonatomic)    bool gameover;
@property (nonatomic,strong)    NSMutableArray *mineArray;
@property (nonatomic,retain)    SKLabelNode *timeLabel;
@property (nonatomic,retain)    SKLabelNode *flagLabel;
@property (nonatomic)    int flagCounter;
@property (nonatomic)    int bombNumber;
@property (nonatomic)    int numBombs;
@property (nonatomic)    int numRows;
@property (nonatomic)    int numCols;
@property (nonatomic)    int timerTime;
@property (nonatomic,retain)    gameButton *gameOver;
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat screenHeight;
@end
