//
//  DoubleFloorBlock.h
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "CCNode.h"
#import "Block.h"


@interface DoubleFloorBlock : Block
-(void) generatePlatforms: (int) size and: (CGPoint)startingPosition;
@end
