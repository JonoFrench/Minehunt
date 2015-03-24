//
//  GameScene.h
//  MineHunt2
//

//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "gameButton.h"
#import "gameTile.h"

@interface GameScene : SKScene <tileDelegate>

@property (nonatomic,retain)    SKLabelNode *timeLabel;
@property (nonatomic,retain)    SKLabelNode *flagLabel;
@property (nonatomic,retain)    gameButton *gameOver;
@property (nonatomic) int gameType;

@end
