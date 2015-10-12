//
//  RandomFloorBlock.m
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "RandomFloorBlock.h"
#import "Platform.h"
@implementation RandomFloorBlock
-(id) init
{
    self = [super init];
    float low_bound = 90;
    float high_bound = 180;
    float platformWidth = [[Platform alloc] init].sprite.contentSize.width;
    float high_bound_size =4;
    float low_bound_size = 1;
    
       
    for (int i =600; i<120000;) {
        float rndValue = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
        float randSize =(((float)arc4random()/0x100000000)*(high_bound_size-low_bound_size)+low_bound_size);
         [self generatePlatforms: 2 and: ccp(i, rndValue)];
        i+=5*platformWidth;
    }
    
    
    
    return self;
}

-(void) generatePlatforms: (int) size and: (CGPoint)startingPosition
{
    
    for (int i = 0; i < size; i++)
    {
        Platform * platform = [[Platform alloc] init];
        platform.position = ccp(startingPosition.x + i * platform.sprite.contentSize.width, startingPosition.y);
        
        [self addChild: platform];
        
    }
    
    
}

@end
