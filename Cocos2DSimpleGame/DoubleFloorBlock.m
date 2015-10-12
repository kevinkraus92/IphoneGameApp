//
//  DoubleFloorBlock.m
//  Cocos2DSimpleGame
//
//  Created by Kevin Kraus on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "DoubleFloorBlock.h"
#import "Platform.h"


@implementation DoubleFloorBlock


-(id) init
{
    self = [super init];
    
    float platformWidth = [[Platform alloc] init].sprite.contentSize.width;

    [self generatePlatforms: 20 and: ccp(600, 150)];
    
    [self generatePlatforms: 20 and: ccp(600 + 20 * platformWidth + 5 * platformWidth, 150)];

    
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
