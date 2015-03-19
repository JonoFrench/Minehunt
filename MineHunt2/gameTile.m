//
//  gameTile.m
//  MineHunt
//
//  Created by Jonathan French on 21/05/2012.
//  Copyright (c) 2015 App Digital Ltd. All rights reserved.
//

#import "gameTile.h"
#import "globalSettings.h"
#import "MineHuntImages.h"

@implementation gameTile

-(instancetype) initWithPositionX:(int)x andY:(int)y Row:(int)row Column:(int)col
{
    SKTexture *tex = [SKTexture textureWithImage:[globalSettings getBlankTile]];
    
    self = [super initWithTexture:tex];
    
    if(self)
    {
        _hasTile = true;
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


-(bool)hasMine{ return _hasMine;}
-(bool)hasFlag{ return _hasFlag;}
-(int)getHint{ return _numHints;}
-(int)getArrayCol{ return _arrayRow;}
-(int)getArrayRow{ return _arrayCol;}
-(bool)hasHint{ return _hasHint;}
-(bool)getGameOver{ return _gameOver;}

-(void)setGameOver:(bool)gameover
{
    _gameOver = gameover;
}
-(void)setHint:(int) hint
{
    _numHints = hint;
    _hasFlag = false;
    _hasMine = false;
}

-(void)setMine:(bool)mine
{
    _hasTile = false;
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
    if (_hasHint == true){return;}
    
    _hasHint = true;
    _hasTile = false;
    
    SKTexture *tex;
    if (_numHints ==0)
    {
        tex = [SKTexture textureWithImage:[globalSettings getEmptyTile]];
    }
    else
    {
        tex = [SKTexture textureWithImage:[globalSettings getNumberTile:_numHints]];
    }
    [self setTexture:tex];
    
    // we don't really want to display a 0
    // but we do need to check our surroundings for other space!
    if(_numHints == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"emptyTile" object:self];
    }
}

-(void)showLetter:(NSString *)letter
{
    SKTexture *tex = [SKTexture textureWithImage:[globalSettings getLetterTile:letter]];
    [self setTexture:tex];
    _hasTile = false;
}

-(void)showTile
{
    SKTexture *tex = [SKTexture textureWithImage:[globalSettings getBlankTile]];
    [self setTexture:tex];
    _hasQuestion = false;
    _hasFlag = false;
}

-(void)showQuestion
{
    SKTexture *tex = [SKTexture textureWithImage:[globalSettings getQuestionTile]];
    [self setTexture:tex];
    _hasQuestion = true;
    _hasFlag = false;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"questButton" object:self];
}

-(void)showFlag
{
    if (!_hasHint)
    {
        SKTexture *tex = [SKTexture textureWithImage:[globalSettings getFlagTile]];
        [self setTexture:tex];
        _hasFlag = true;
        _hasQuestion = false;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"checkFlags" object:self];
    }
}

-(void)showBomb:(float)expcount
{
    SKTexture *tex = [SKTexture textureWithImage:[globalSettings getMineTile]];
    [self setTexture:tex];
    [NSTimer scheduledTimerWithTimeInterval:expcount target:self selector:@selector(explosion) userInfo:nil repeats:NO];
}

-(void)explosion
{
    SKAction* soundAction = [SKAction playSoundFileNamed:@"explosion.caf" waitForCompletion:NO];
    [self runAction:soundAction];
    SKTexture *tex = [SKTexture textureWithImage:[globalSettings getExplosionTile]];
    [self setTexture:tex];
    SKEmitterNode* smokeTrail;
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"spark" ofType:@"sks"];
    smokeTrail = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smokeTrail.position = self.position;
    [self.parent addChild:smokeTrail];
}

-(void)showExplosion
{
    [self explosion];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gameOver" object:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
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
