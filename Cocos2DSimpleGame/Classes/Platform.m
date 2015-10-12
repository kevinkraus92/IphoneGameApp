//
//  Platform.m
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "Platform.h"

@implementation Platform

-(id) init
{
    self = [super init];
    _sprite= [CCSprite spriteWithImageNamed:@"step.png"];
    [self addChild: _sprite];
    _sprite.anchorPoint = CGPointMake(0, 0);
    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, _sprite.contentSize} cornerRadius:0];
    self.physicsBody.type = CCPhysicsBodyTypeStatic;
    self.physicsBody.friction = 0;
    self.physicsBody.elasticity = 0;
    self.physicsBody.collisionGroup = @"platformGroup";
    self.physicsBody.collisionType  = @"platformCollision";
    return self;
}
@end
