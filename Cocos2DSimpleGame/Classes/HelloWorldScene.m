//
//  HelloWorldScene.m
//  Cocos2DSimpleGame
//
//  Created by Martin Walsh on 18/01/2014.
//  Copyright Razeware LLC 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"
#import "NewtonScene.h"
#import "LevelGround.h"
#import "Block.h"
#import "DoubleFloorBlock.h"
#import "RandomFloorBlock.h"
#import "Projectile.h"
#import "CCLabelTTF.h"


// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    // 1
    CCPhysicsNode *_physicsWorld;

    CCSprite *_backgroundTop1;
    CCSprite *_backgroundTop2;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    _gameOverFlag = false;
    
    //[[OALSimpleAudio sharedInstance] playBg:@"map.caf" loop:YES];
    // top
    _backgroundTop1             = [CCSprite spriteWithImageNamed:@"MarioBackground-scrolling-top.png"];
    _backgroundTop1.anchorPoint = ccp(0, 0);
    _backgroundTop1.position    = ccp(0, self.contentSize.height - _backgroundTop1.contentSize.height);
    [self addChild:_backgroundTop1];
  
    
    _levelGround = [[LevelGround alloc] init];
    [_levelGround setCollisionDelegator:self];
    [self addChild:_levelGround];
    
    // Create left trigger
  
    CCNode* _leftTrigger = [CCNode node];
    
    _leftTrigger.position = ccp(0, 0);
    _leftTrigger.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(-50, 0, 50, self.contentSize.height) cornerRadius:0.0f];
    _leftTrigger.physicsBody.type = CCPhysicsBodyTypeStatic;
    _leftTrigger.physicsBody.sensor=YES;
    _leftTrigger.physicsBody.collisionGroup = @"triggerGroup";
    _leftTrigger.physicsBody.collisionType= @"leftTriggerCollision";
    
   

  
    // Create right trigger
    CCNode* _rightTrigger = [CCNode node];
    _rightTrigger.position = ccp(0, 0);
    _rightTrigger.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(self.contentSize.width, 0, 50, self.contentSize.height) cornerRadius:0.0f];
    _rightTrigger.physicsBody.type = CCPhysicsBodyTypeStatic;
    _rightTrigger.physicsBody.friction = 0;
    _rightTrigger.physicsBody.elasticity = 1.0f;
    _rightTrigger.physicsBody.collisionGroup = @"triggerGroup";
    _rightTrigger.physicsBody.collisionType  = @"rightTriggerCollision";
    _rightTrigger.physicsBody.sensor=YES;
    

  
    
    
    //Block* block= [[DoubleFloorBlock alloc] init];
    Block* block = [[RandomFloorBlock alloc] init];
    block.position = ccp(0, 0);
    [_levelGround.physicsNode addChild:block];
    
    
    // Create a ground (we should create a class and update it like player to move right)
    CCNode* _ground = [CCNode node];
    _ground.position = ccp(0, 0);
    _ground.physicsBody = [CCPhysicsBody bodyWithPolylineFromRect:CGRectMake(0 , 0.10*self.contentSize.width, self.contentSize.width + 50 + 50*9999999999999, self.contentSize.height) cornerRadius:0.0f];
    _ground.physicsBody.type = CCPhysicsBodyTypeStatic;
    
    _ground.physicsBody.friction = 0;
    _ground.physicsBody.elasticity = 1.0f;
    _ground.physicsBody.collisionGroup = @"groundGroup";
    _ground.physicsBody.collisionType  = @"groundCollision";
    [_levelGround.physicsNode addChild:_ground];
    
    
    _playerReference = [[Player alloc] init];
    _playerReference.position  = ccp(self.contentSize.width/8,0.2*self.contentSize.width);
    [_levelGround.physicsNode addChild:_playerReference];

	return self;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair monsterCollision:(Monster *)monster projectileCollision:(CCNode *)projectile {
    [monster removeFromParent];
    [projectile removeFromParent];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair monsterCollision:(CCSprite *)monster playerCollision:(Player *)playerReference {
    [monster removeFromParent];
    [playerReference removeFromParent];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair groundCollision:(CCNode*) ground  playerCollision:(Player *)player {
    [player resetJumps];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair platformCollision:(CCNode*) platform  playerCollision:(Player *)player {
    [player resetJumps];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair groundCollision:(CCNode*) ground  projectileCollision:(CCNode*)projectile {
    [projectile removeFromParent];
    return YES;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
  
    [self schedule:@selector(scrollBackground:) interval:0.005];

}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    // 1
    if(_gameOverFlag){
         [self gameOver];
    }else{
        CGPoint touchLocation = [touch locationInNode:self];
        if(touchLocation.x < self.contentSize.width/2 ){
            //        [_playerReference.physicsBody applyImpulse: ccp(0.0f, 20000)];
            [_playerReference jump];
            
        } else{
            Projectile* projectile = [[Projectile alloc] init];
            projectile.position = ccp(_playerReference.position.x+10, _playerReference.position.y+20);
            [_levelGround.physicsNode addChild:projectile];
        }

    }
}


- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair projectileCollision:(CCNode *)projectile monsterCollision:(CCNode *)monster {
    [projectile removeFromParent];
    [monster removeFromParent];

    
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair rightTriggerCollision:(CCNode *)trigger projectileCollision:(CCNode *)projectile {
    NSLog(@"Borde derecho");
    [projectile removeFromParent];
    return YES;
}
- (void) gameOver
{
    HelloWorldScene* gameOverScene = [[HelloWorldScene alloc] init];
    [[CCDirector sharedDirector] replaceScene:(HelloWorldScene*) gameOverScene ];
    
}


- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(Player *)playerReference2 monsterCollision:(Monster *)monster {
    
    CCLabelTTF* ttf1 = [CCLabelTTF labelWithString: @"Game Over" fontName:@"Helvetica" fontSize:15];
    CCLabelTTF* ttf2 = [CCLabelTTF labelWithString: @"Touch anywhere to restart" fontName:@"Helvetica" fontSize:15];
    ttf1.position = ccp(250,150);
    ttf2.position = ccp(250, 130);
    [self addChild: ttf1];
    [self addChild: ttf2];
    _gameOverFlag = true;
    [_playerReference removeFromParent];
   
    return YES;
}


- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair leftTriggerCollision:(CCNode *)trigger playerCollision:(Player *)playerReference2 {
    _gameOverFlag=true;
    [playerReference2 removeFromParent];
    NSLog(@"termino el juego");
    return YES;
}


- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair horizontalTriggerCollision:(CCNode *)trigger playerCollision:(CCSprite *)player {
    NSLog(@"toque el piso");
    //TODO
    return YES;
}
// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

- (void)onNewtonClicked:(id)sender
{
    [[CCDirector sharedDirector] pushScene:[NewtonScene scene] withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

- (void) scrollBackground:(CCTime)dt
{
   
    int r = arc4random_uniform(10000000 );

    if (r>9980000){
        Monster* monster = [[Monster alloc] init];
        monster.position = CGPointMake(abs(_levelGround.position.x) + self.contentSize.width, 200);
        [_levelGround.physicsNode addChild:monster];
    }
   }


// -----------------------------------------------------------------------
@end