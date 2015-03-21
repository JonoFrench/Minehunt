//
//  GameScene.m
//  MineHunt2
//
//  Created by Jonathan French on 17/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import "GameScene.h"
#import "MineHuntImages.h"
#import "gameTile.h"
#import "highScores.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emptyTileNotification:) name:@"emptyTile" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOverNotification:) name:@"gameOver" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkFlagsNotification:) name:@"checkFlags" object:nil];    
    
    _screenWidth = view.bounds.size.width;
    _screenHeight = view.bounds.size.height;
    _numBombs = 8;
    _numRows = 8;
    _numCols = 8;

    _timerTime = 0;
    _flagCounter = _numBombs;
    _gameover = false;
    
    _timeLabel = [SKLabelNode labelNodeWithFontNamed:@"Marker Felt"];
    _timeLabel.text = @"Time: 0:00";
    _timeLabel.fontSize = 24;
    _timeLabel.position = CGPointMake(30,30);
    _timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:_timeLabel];

    _flagLabel = [SKLabelNode labelNodeWithFontNamed:@"Marker Felt"];
    _flagLabel.text = @"Flag: 0";
    _flagLabel.fontSize = 24;
    _flagLabel.position = CGPointMake(210,30);
    [self flagNumber];
    _flagLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:_flagLabel];
    [self setGame];
    
    //Set the clock timer
    NSTimer *clockTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerShowTick:) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:clockTimer forMode:NSDefaultRunLoopMode];
}

-(void)setGame
{
    int tilesize = _screenWidth/_numCols;
    int startpos = _screenHeight-(tilesize/2);
    int x,y;

    _mineArray = [[NSMutableArray alloc]initWithCapacity:_numRows];
    gameTile * gt;

    for (int x1=0; x1<_numRows; x1++) {
        NSMutableArray *colArray = [[NSMutableArray alloc]initWithCapacity:_numCols];
        for (int y1=0; y1<_numCols; y1++) {
            gt = [[gameTile alloc] initWithPositionX:(tilesize/2)+(y1*tilesize) andY:startpos-(x1*tilesize) Row:x1 Column:y1 TileSize:tilesize];
            [colArray insertObject:gt atIndex:y1];
            [self addChild:gt];
        }
        [_mineArray insertObject:colArray atIndex:x1];
    }

    for (int mines=0; mines<=_numBombs; mines++) {
        x = arc4random()%_numRows;
        y = arc4random()%_numCols;
        gameTile * gt = [[_mineArray objectAtIndex:x]objectAtIndex:y]; //minearray[x][y];
        if(![gt hasMine])
        {
            [gt setMine:true];
        }  
    }
    
    //set hints
    int c=0;
    for (int x1=0; x1<_numRows; x1++) {
        for (int y1=0; y1<_numCols; y1++) {
            gameTile * gt = [[_mineArray objectAtIndex:x1]objectAtIndex:y1];
            if(![gt hasMine])
            {
                c = [self getHint:x1 col:y1];
                [gt setHint:c];
            }
        }
    }
}

-(int)getHint:(int)row col:(int)col
{
    int hint = 0;
    int startcol,startrow;
    int endcol,endrow;
    
    startcol = MAX(0, col-1);
    endcol = MIN(_numCols-1, col+1);
    startrow = MAX(0, row-1);
    endrow = MIN(_numRows-1, row+1);
    
    for(int r = startrow; r<=endrow;r++)
    {
        for (int c = startcol;c<=endcol;c++){
            gameTile * gt = [[_mineArray objectAtIndex:r]objectAtIndex:c];
            if ([gt hasMine]) {
                hint++;
            }
        }
    }
    return hint;
}

-(void)checkAround:(int)row col:(int)col
{
    int startcol,startrow;
    int endcol,endrow;
    
    startcol = MAX(0, col-1);
    endcol = MIN(_numCols-1, col+1);
    startrow = MAX(0, row-1);
    endrow = MIN(_numRows-1, row+1);
    
    for(int r = startrow; r<=endrow;r++)
    {
        for (int c = startcol;c<=endcol;c++){
            gameTile * gt = [[_mineArray objectAtIndex:r]objectAtIndex:c];
            if (![gt hasMine] && ![gt hasHint]) {
                [gt showHint];
            }
        }
    }
}

-(void)emptyTileNotification:(NSNotification *) notification
{
    gameTile * gt = [notification object];
    [self checkAround:[gt getArrayCol] col:[gt getArrayRow]];
//    NSLog(@"emptyTile Triggered! row %d, col %d",[gt getArrayRow],[gt getArrayCol]);
}

-(void)checkFlagsNotification:(NSNotification *) notification
{
    _flagCounter--;
    [self flagNumber];
    int c=0;
    for (int x1=0; x1<_numRows; x1++) {
        for (int y1=0; y1<_numCols; y1++) {
            gameTile * gt = [[_mineArray objectAtIndex:x1]objectAtIndex:y1];
            if([gt hasMine] == true && [gt hasFlag]==true)
            {
                c++;
            }
        }
    }
    
    if (c==_numBombs)
    {
        _gameover = true;        
        //add the score to the highscore
        highScores *hs = [[highScores alloc]init];
        [hs newScore:_timerTime];
        SKTexture *tex = [SKTexture textureWithImage:[MineHuntImages imageOfWonWithFrame:CGRectMake(0, 0,_screenWidth/2,(_screenWidth/2)/3)]];
        _gameOver = [[gameButton alloc]initWithTexture:tex];
        [_gameOver setPosition:CGPointMake(_screenWidth/2, 50+(_screenWidth/2)/3)];
        [_gameOver setTouchUpInsideTarget:self action:@selector(gameReturn)];
        [self addChild:_gameOver];
    }
}

-(void)gameOverNotification:(NSNotification *) notification
{
    float expcount = 0.25;
    for (int x1=0; x1<_numRows; x1++) {
        for (int y1=0; y1<_numCols; y1++) {
            gameTile * gt = [[_mineArray objectAtIndex:x1]objectAtIndex:y1];
            if([gt getGameOver] != true && [gt hasMine]==true)
            {
                [gt setGameOver:YES];
                [gt showBomb:expcount];
                //add .25 of a second till next explosion
                expcount+=0.25;
            }
                [gt setGameOver:YES];
        }
    }
    
    _gameover = true;
    
    SKTexture *tex = [SKTexture textureWithImage:[MineHuntImages imageOfGameOverWithFrame:CGRectMake(0, 0,_screenWidth/2,(_screenWidth/2)/3)]];
    _gameOver = [[gameButton alloc]initWithTexture:tex];
    [_gameOver setTouchUpInsideTarget:self action:@selector(gameReturn)];
    [_gameOver setPosition:CGPointMake(_screenWidth/2, 50+(_screenWidth/2)/3)];
    [self addChild:_gameOver];
}

-(void)gameReturn
{
    _mineArray = nil;
    [self.view presentScene:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"menuReturn" object:self];
}

-(void)timerShowTick:(NSTimer *)timer
{
    if (!_gameover)
    {
        _timerTime++;
    }
    int sec = _timerTime %60;
    int min = _timerTime /60;
    [_timeLabel setText:[NSString stringWithFormat:@"Time: %d:%.2d",min,sec]];
}

-(void)flagNumber
{
    [_flagLabel setText:[NSString stringWithFormat:@"Flag: %d",_flagCounter]];
}




@end
