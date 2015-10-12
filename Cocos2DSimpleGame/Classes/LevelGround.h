//
//  LevelGround.h
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 22/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "CCNode.h"
#import "CCSprite.h"
#import "CCPhysicsBody.h"
#import "CCPhysicsNode.h"
#import "Player.h"
@class HelloWorldScene;


@interface LevelGround : CCNode

@property CCSprite *background1;
@property Player *player;
@property CCSprite *background2;
@property int whichBackground;
@property bool waitForBackgroundChange;
@property (nonatomic) int movX;
@property (nonatomic, weak) CCSprite* currentBg;
@property __strong CCPhysicsNode* physicsNode;
-(void) setCollisionDelegator: (CCScene <CCPhysicsCollisionDelegate>*) scene;

@end