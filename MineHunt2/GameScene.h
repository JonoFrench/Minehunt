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
@property (nonatomic,strong)    SKLabelNode *timeLabel;
@property (nonatomic,strong)    SKLabelNode *flagLabel;
@property (nonatomic)    int flagCounter;
@property (nonatomic)    int bombNumber;
@property (nonatomic,strong)    gameButton *gameOver;
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat screenHeight;
@end
