//
//  gameTile.h
//  MineHunt
//
//  Created by Jonathan French on 21/05/2012.
//  Copyright (c) 2012 Home. All rights reserved.
//

#import "MineHuntImages.h"
#import <SpriteKit/SpriteKit.h>


typedef enum tagTileState {
	kTileStateTouched,
	kTileStateUnTouched
} TileState;

@interface gameTile :SKSpriteNode
{
    @private TileState state;
}

@property (nonatomic,getter=hasMine) bool hasMine;
@property (nonatomic,getter=hasQuestion) bool hasQuestion;
@property (nonatomic,getter=hasFlag) bool hasFlag;
@property (nonatomic,getter=hasHint) bool hasHint;

@property (nonatomic) int arrayCol;
@property (nonatomic) int arrayRow;
@property (nonatomic) int gameOver;

-(id) initWithPositionX:(int)x andY:(int)y Row:(int)row Column:(int)col TileSize:(int)tilesize;
-(int)getHint;
-(void)setHint:(int) hint;
-(void)setMine:(bool)mine;
-(void)setFlag:(bool)flag;

-(void)showHint;
-(void)showBomb:(float)expcount;
-(void)showLetter:(NSString *)letter;

@end
