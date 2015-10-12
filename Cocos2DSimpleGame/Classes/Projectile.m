//
//  Projectile.m
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "Projectile.h"
#import "CCSprite.h"
#import "CCPhysicsNode.h"
#import "CCPhysicsBody.h"


@implementation Projectile 
-(id) init
{

   // CCSprite *projectile = [CCSprite spriteWithImageNamed:@"projectile.png"];
    self =[super initWithImageNamed:@"projectile.png"];

    self.anchorPoint = CGPointMake(1.7, 0.5);
    
    self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:self.contentSize.width/2 andCenter:self.anchorPointInPoints];
    
    self.physicsBody.collisionGroup = @"projectileGroup";
    self.physicsBody.collisionType  = @"projectileCollision";
    self.physicsBody.velocity = CGPointMake(100, 200);
    self.physicsBody.friction = 0;
    self.physicsBody.elasticity = 0;
    self.physicsBody.mass=0.01;
    return self;
}

-(void) update:(CCTime)delta
{
    float mov = 360.0f * delta;
    self.position = CGPointMake(self.position.x + 2*mov, self.position.y);
}



@end
