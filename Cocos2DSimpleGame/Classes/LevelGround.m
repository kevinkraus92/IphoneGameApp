//
//  LevelGround.m
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 22/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "LevelGround.h"
#import "HelloWorldScene.h"

@implementation LevelGround


-(id) init
{
    self = [super init];
    
    NSLog(@"init!");

    self.positionType = CCPositionTypePoints;
    self.position = CGPointMake(0.5f,0.5f);
    
    // bottom
    _background1             = [CCSprite spriteWithImageNamed:@"MarioBackground-scrolling.png"];
    _background1.anchorPoint = ccp(0, 0);
    _background1.position    = ccp(0, 0);
    _background1.physicsBody.collisionGroup = @"playerGroup";
    _background1.physicsBody.collisionType =@"levelGroundCollision";
    [self addChild:_background1];
    
    _background2             = [CCSprite spriteWithImageNamed:@"MarioBackground-scrolling.png"];
    _background2.anchorPoint = ccp(0, 0);
    _background2.physicsBody.collisionGroup = @"playerGroup";
    _background2.physicsBody.collisionType =@"levelGroundCollision";
    _background2.position    = ccp([_background1 boundingBox].size.width-1, 0);
    [self addChild:_background2];
    
    self.currentBg = _background1;
    _physicsNode = [CCPhysicsNode node];
    _physicsNode.gravity           = ccp(0, -300);
    _physicsNode.debugDraw         = false;
    
    [self addChild: _physicsNode];

    return self;
}

-(void) update:(CCTime)delta
{
    float mov = 360.0f * delta;
    self.movX += mov;
    self.position = CGPointMake(self.position.x - mov, self.position.y);


    if (self.movX + mov  >= _background1.contentSize.width) {
        self.movX = self.movX + mov  - _background1.contentSize.width;

        CCSprite* otherBackground = _currentBg == _background1 ? _background2 : _background1;
        
        _currentBg.position = CGPointMake(otherBackground.position.x + otherBackground.contentSize.width, _currentBg.position.y);
        
        CCSprite* temp = otherBackground;
        otherBackground = _currentBg;
        _currentBg = temp;
    }

}

-(void) setCollisionDelegator: (CCScene <CCPhysicsCollisionDelegate>*) scene
{
   self.physicsNode.collisionDelegate = scene;
}

@end
