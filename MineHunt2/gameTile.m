//
//  gameTile.m
//  MineHunt
//
//  Created by Jonathan French on 21/05/2012.
//  Copyright (c) 2015 App Digital Ltd. All rights reserved.
//

#import "gameTile.h"
#import "MineHuntImages.h"

@interface gameTile()

@property (strong,nonatomic) SKTexture *tex;
@property (strong,nonatomic) SKEmitterNode* smokeTrail;
@property (strong,nonatomic) SKAction* soundAction;
@property (nonatomic) CGRect tileSize;
@property (nonatomic) int tileTap;
@property (nonatomic) int width;
@property (nonatomic) int xpos;
@property (nonatomic) int ypos;
@property (nonatomic) int numHints;
@end

@implementation gameTile

-(instancetype) initWithPositionX:(int)x andY:(int)y Row:(int)row Column:(int)col TileSize:(int)tilesize
{
    _tileSize = CGRectMake(0, 0, tilesize, tilesize);
    _tex = [SKTexture textureWithImage:[MineHuntImages imageOfBlankWithFrame:_tileSize]];
    
    self = [super initWithTexture:_tex];
    
    if(self)
    {
        _hasFlag = false;
        _hasMine = false;
        _hasHint = false;
        _numHints=0;
        _gameOver = false;
        _hasQuestion=false;
        _tileTap=0;
        state = kTileStateUnTouched;
        _arrayCol = col;
        _arrayRow = row;
        self.xScale = 1;
        self.yScale = 1;
        self.position = CGPointMake(x, y);
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(int)getHint{ return _numHints;}

-(void)setHint:(int) hint
{
    _numHints = hint;
    _hasFlag = false;
    _hasMine = false;
}

-(void)setMine:(bool)mine
{
    _hasMine = mine;
    _hasFlag = false;
    _hasHint = false;
    _numHints = 0;
}

-(void)setFlag:(bool)flag
{
    _hasFlag = flag;
}

-(void)showHint
{
    // check if we've already been here
    if (_hasHint || _hasFlag) return;
    
    _hasHint = true;
    
    if (_numHints ==0)
    {
        _tex = [SKTexture textureWithImage:[MineHuntImages imageOfEmptyWithFrame:_tileSize]];
        // we don't really want to display a 0
        // but we do need to check our surroundings for other space!
        [[NSNotificationCenter defaultCenter] postNotificationName:@"emptyTile" object:self];}
    else
    {
        _tex = [SKTexture textureWithImage:[MineHuntImages imageOfBombCountWithFrame:_tileSize numBombs:[NSString stringWithFormat:@"%d",_numHints]]];
    }
    [self setTexture:_tex];

}

-(void)showLetter:(NSString *)letter
{
    _tex = [SKTexture textureWithImage:[MineHuntImages imageOfBombCountWithFrame:_tileSize numBombs:letter]];
    [self setTexture:_tex];
}

-(void)showTile
{
    _tex = [SKTexture textureWithImage:[MineHuntImages imageOfBlankWithFrame:_tileSize]];
    [self setTexture:_tex];
    _hasQuestion = false;
    _hasFlag = false;
}

-(void)showQuestion
{
    _tex = [SKTexture textureWithImage:[MineHuntImages imageOfQuestionWithFrame:_tileSize]];
    [self setTexture:_tex];
    _hasQuestion = true;
    _hasFlag = false;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"questButton" object:self];
}

-(void)showFlag
{
    // check that all the flags available havent been planted. Use the delegate call back to GameScene
    if (![self.tileDelegate checkFlag]) {
        return;
    }
    
    if (!_hasHint)
    {
        _tex = [SKTexture textureWithImage:[MineHuntImages imageOfFlagWithFrame:_tileSize]];
        [self setTexture:_tex];
        _hasFlag = true;
        _hasQuestion = false;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"checkFlags" object:self];
    }
}

-(void)showBomb:(float)expcount
{
    _tex = [SKTexture textureWithImage:[MineHuntImages imageOfMineWithFrame:_tileSize]];
    [self setTexture:_tex];
    [NSTimer scheduledTimerWithTimeInterval:expcount target:self selector:@selector(explosion) userInfo:nil repeats:NO];
}

-(void)explosion
{
    _soundAction = [SKAction playSoundFileNamed:@"explosion.caf" waitForCompletion:NO];
    [self runAction:_soundAction];
    _tex = [SKTexture textureWithImage:[MineHuntImages imageOfExplosionWithFrame:_tileSize]];
    [self setTexture:_tex];
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"spark" ofType:@"sks"];
    _smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    _smokeTrail.position = self.position;
    [self.parent addChild:_smokeTrail];
}

-(void)showExplosion
{
    [self explosion];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameOver" object:self];
}

#pragma mark touch 

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_gameOver) return;
    if (state != kTileStateUnTouched) return;
    _tileTap++;
    state = kTileStateTouched;
    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_gameOver) return;
    state = kTileStateUnTouched;
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(taphandler:) userInfo:nil repeats:NO];
}


-(void)taphandler:(NSTimer *) timer
{
    if(_tileTap==0) return;
    switch (_tileTap) {
        case 1:
        {
            // Single tap
            
            if (self.hasFlag) {
                [self showQuestion];
                return;
            }
            
            if (_hasQuestion) {
                [self showTile];
                return;
            }
            
            if (self.hasMine) {
                [self showExplosion];
            }
            else {
                [self showHint];
            }
        }
            break;
        case 2:
        {
            // double tap
            if (self.hasFlag) {
                return;
            }
            if (_hasQuestion) {
                [self showTile];
            }
            else
            {
                [self showFlag];
            }
        }
            break;
            
        default:
            break;
    }
    _tileTap=0;
}

@end
