//
//  MyScene.h
//  bootybootybooty
//

//  Copyright (c) 2014 pk inc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
typedef enum{
    left,
    right,
    up,
    down,
    none
}Direction;

@interface MyScene : SKScene <SKPhysicsContactDelegate> {
	NSTimer *timer;
}
@property (nonatomic, strong) SKSpriteNode *playerSprite;
@property (nonatomic, strong) SKSpriteNode *upButtonSprite;
@property (nonatomic, strong) SKSpriteNode *downButtonSprite;
@property (nonatomic, strong) SKSpriteNode *leftButtonSprite;
@property (nonatomic, strong) SKSpriteNode *rightButtonSprite;
@property (atomic, assign) Direction currentDirection;
@property (nonatomic, assign) BOOL gameOver;
@property (nonatomic, strong) NSMutableArray *asteroids;
@end