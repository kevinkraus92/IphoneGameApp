//
//  Monster.m
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 30/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "Monster.h"

@implementation Monster

-(id) init
{
    self =[super initWithImageNamed:@"monster.png"];
    
    self.positionType = CCPositionTypePoints;
    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
    self.physicsBody.collisionGroup = @"monsterGroup";
    self.physicsBody.collisionType  = @"monsterCollision";
    self.physicsBody.velocity =CGPointMake(200, 0);
    self.physicsBody.friction = 0;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.mass = 100;
    self.physicsBody.elasticity = 0;
    return self;
}

-(void) update:(CCTime)delta
{
    self.rotation = 0;
    self.position = CGPointMake(self.position.x - 5, self.position.y);
    
}
@end