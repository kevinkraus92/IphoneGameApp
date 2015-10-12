//
//  Player.m
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id) init
{
    self = [super init];
    
    _sprite = [CCSprite spriteWithImageNamed:@"player.png"];
    _sprite.anchorPoint = CGPointMake(0.5, 0);
    
    [self addChild: _sprite];
    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, _sprite.contentSize} cornerRadius:0];
    self.physicsBody.mass=100;
    [self resetJumps];
    self.physicsBody.friction = 0;
    self.physicsBody.elasticity = 0;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.collisionType  = @"playerCollision";
    self.physicsBody.collisionGroup = @"playerCollisionGroup";
    return self;
}

-(void) update:(CCTime)delta
{
    float mov = 360.0f * delta;
    self.position = CGPointMake(self.position.x + mov, self.position.y);
    self.rotation = 0;

}

-(void) jump
{
    _jumps++;
    if(_jumps<3){
        [self.physicsBody applyImpulse: ccp(0.0f, self.physicsBody.mass * 30000)];
        
    }
}
-(void) resetJumps
{
    _jumps=0;

}


@end
