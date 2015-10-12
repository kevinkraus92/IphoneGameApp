//
//  Player.h
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "CCNode.h"
#import "CCSprite.h"
#import "CCPhysicsNode.h"
#import "CCPhysicsBody.h"


@interface Player : CCNode
    @property CCSprite* sprite;
    @property int jumps;


- (void)jump;
- (void) resetJumps;
@end
