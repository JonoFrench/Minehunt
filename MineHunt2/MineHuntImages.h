//
//  MineHuntImages.h
//  MineHunt
//
//  Created by Jonathan French on 18/03/2015.
//  Copyright (c) 2015 App Digital. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface MineHuntImages : NSObject

// Colors
+ (UIColor*)redColour;
+ (UIColor*)yellowColour;
+ (UIColor*)blueColour;
+ (UIColor*)greenColour;
+ (UIColor*)whiteColour;
+ (UIColor*)blackColour;
+ (UIColor*)greyColour;
+ (UIColor*)orangeColour;

// Shadows
+ (NSShadow*)shadow;

// Drawing Methods
+ (void)drawBlankWithFrame: (CGRect)frame;
+ (void)drawMineWithFrame: (CGRect)frame;
+ (void)drawBombCountWithFrame: (CGRect)frame numBombs: (NSString*)numBombs;
+ (void)drawFlagWithFrame: (CGRect)frame;
+ (void)drawQuestionWithFrame: (CGRect)frame;
+ (void)drawExplosionWithFrame: (CGRect)frame;
+ (void)drawEmptyWithFrame: (CGRect)frame;
+ (void)drawButtonWithFrame: (CGRect)frame;
+ (void)drawGameOverWithFrame: (CGRect)frame;
+ (void)drawWonWithFrame: (CGRect)frame;

// Generated Images
+ (UIImage*)imageOfBlankWithFrame: (CGRect)frame;
+ (UIImage*)imageOfMineWithFrame: (CGRect)frame;
+ (UIImage*)imageOfBombCountWithFrame: (CGRect)frame numBombs: (NSString*)numBombs;
+ (UIImage*)imageOfFlagWithFrame: (CGRect)frame;
+ (UIImage*)imageOfQuestionWithFrame: (CGRect)frame;
+ (UIImage*)imageOfExplosionWithFrame: (CGRect)frame;
+ (UIImage*)imageOfEmptyWithFrame: (CGRect)frame;
+ (UIImage*)imageOfButtonWithFrame: (CGRect)frame;
+ (UIImage*)imageOfGameOverWithFrame: (CGRect)frame;
+ (UIImage*)imageOfWonWithFrame: (CGRect)frame;

@end



@interface NSShadow (PaintCodeAdditions)

+ (instancetype)shadowWithColor: (UIColor*)color offset: (CGSize)offset blurRadius: (CGFloat)blurRadius;
- (void)set;

@end
