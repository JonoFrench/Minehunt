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


//@interface gameTile : CCSprite  <CCStandardTouchDelegate> 
@interface gameTile :SKSpriteNode
{
@private
	TileState state;
    
    bool _hasMine;
    bool _hasQuestion;
    bool _hasFlag;
    bool _hasHint;
    bool _gameOver;
    bool _hasTile;
    int _numHints;
    int width;
    int xpos;
    int ypos;
    int _arrayCol;
    int _arrayRow;
    int _tileTap;
}
@property (strong,nonatomic) SKTexture *tex;
@property (strong,nonatomic) SKEmitterNode* smokeTrail;
@property (strong,nonatomic) SKAction* soundAction;
@property (nonatomic) CGRect tileSize;

-(bool)hasMine;
-(bool)hasFlag;
-(bool)hasHint;

-(bool)getGameOver;

-(int)getHint;
-(int)getArrayCol;
-(int)getArrayRow;
-(void)setHint:(int) hint;
-(void)setMine:(bool)mine;
-(void)setFlag:(bool)flag;
-(void)setGameOver:(bool)gameover;

-(id) initWithPositionX:(int)x andY:(int)y Row:(int)row Column:(int)col TileSize:(int)tilesize;
-(void)showHint;
-(void)showBomb:(float)expcount;
-(void)showLetter:(NSString *)letter;

@end
