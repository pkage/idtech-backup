//
//  MyScene.m
//  bootybootybooty
//
//  Created by iD Student on 6/20/14.
//  Copyright (c) 2014 pk inc. All rights reserved.
//

#import "MyScene.h"
#import "Asteroid.h"

#define WALL_CATEGORY 0x1 << 0
#define ROCKET_CATEGORY 0x1 << 1
#define ASTEROID_CATEGORY 0x1 << 2
#define MAX_VELOCITY 25.0

@implementation MyScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.scaleMode = SKSceneScaleModeAspectFill;
        self.physicsWorld.contactDelegate = self;
		
        //Create the DPad
        [self createDPad];
        
        //Let's keep our spaceship within the bounds of the screen!
        SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        //Don't reduce the velocity of objects that come in contact with the wall.
        self.physicsBody.friction = 0.0f;
		borderBody.collisionBitMask = WALL_CATEGORY;
        self.physicsBody = borderBody;
        //Set up the player spaceship sprite.
        self.playerSprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        [self.playerSprite setScale:0.15];
        [self.playerSprite setPosition: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        [self.playerSprite setName:@"playerSprite"];
        [self.playerSprite setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:self.playerSprite.frame.size.width/2.3]];
        //Change Spaceship properties.
	    [self.playerSprite.physicsBody setLinearDamping:1.0];
        [self.playerSprite.physicsBody setUsesPreciseCollisionDetection:YES];
        [self.playerSprite.physicsBody setAllowsRotation:NO];
        [self.playerSprite.physicsBody setDynamic:YES];
        
        [self addChild:self.playerSprite];
        
        //Set current direction to none.
        self.currentDirection = none;
        
		//Set gravity to zero.
        [self.physicsWorld setGravity:CGVectorMake(0.0, 0.0)];
        
        self.gameOver = NO;
        
        //Instantiate the asteroid array.
        self.asteroids = [[NSMutableArray alloc]init];
        
        //Add the timer to the run loop.
        timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(spawnAsteroid) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
		//Let's keep our spaceship within the bounds of the screen!
//        SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
  //      self.physicsBody = borderBody;
		//Don't reduce the velocity of objects that come in contact with the wall.
		self.playerSprite.physicsBody.categoryBitMask = ROCKET_CATEGORY;
		self.playerSprite.physicsBody.collisionBitMask = WALL_CATEGORY;
		self.playerSprite.physicsBody.contactTestBitMask = ASTEROID_CATEGORY;
        self.physicsBody.friction = 0.0f;
    }
    return self;
}
/*
 -(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        // Setup your scene here
		self.physicsWorld.contactDelegate = self;
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.playerSprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        [self.playerSprite setScale:0.15];
        [self.playerSprite setPosition: CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        [self.playerSprite setName:@"playerSprite"];
        [self.playerSprite setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:self.playerSprite.frame.size.width/2.3]];
		self.currentDirection = none;
		
        //Set Gravity to zero.
		[self.physicsWorld setGravity:CGVectorMake(0.0, 0.0)];
        [self addChild:self.playerSprite];
		
        [self createDPad];
    }
    return self;
}
*/

/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}*/

-(void)update:(CFTimeInterval)currentTime {
    //Determine the amount to spin.
    //Calculate the delta_x and delta_y based on angle of ship.
    float currentZ = self.playerSprite.zRotation;
    if(self.currentDirection == up){
        [self.playerSprite.physicsBody applyForce:CGVectorMake(sinf(currentZ)*-50.0, cosf(currentZ)*50.0)];
    }else if(self.currentDirection == down){
        [self.playerSprite.physicsBody applyForce:CGVectorMake(sinf(currentZ)*50.0, cosf(currentZ)*-50.0)];
    }else if(self.currentDirection == left){
        [self.playerSprite setZRotation:currentZ+M_PI*2.0/180.0];
    }else if(self.currentDirection == right){
        [self.playerSprite setZRotation:currentZ-M_PI*2.0/180.0];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//Determine the type of touch.
	for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (CGRectContainsPoint(self.upButtonSprite.frame, location)) {
            self.currentDirection = up;
        }
        if (CGRectContainsPoint(self.downButtonSprite.frame, location)) {
            self.currentDirection = down;
        }
        if (CGRectContainsPoint(self.leftButtonSprite.frame, location)) {
            self.currentDirection = left;
        }
        if (CGRectContainsPoint(self.rightButtonSprite.frame, location)) {
            self.currentDirection = right;
        }
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //Determine the type of touch.
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (CGRectContainsPoint(self.upButtonSprite.frame, location)) {
            self.currentDirection = up;
        }
        else if (CGRectContainsPoint(self.downButtonSprite.frame, location)) {
            self.currentDirection = down;
        }
        else if (CGRectContainsPoint(self.leftButtonSprite.frame, location)) {
            self.currentDirection = left;
        }
        else if (CGRectContainsPoint(self.rightButtonSprite.frame, location)) {
            self.currentDirection = right;
        }
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    if (allTouches.count - touches.count == 0) {
        self.currentDirection = none;
    }
}
-(void)didBeginContact:(SKPhysicsContact *)contact{
	if (contact.bodyA.collisionBitMask == ROCKET_CATEGORY && contact.bodyB.collisionBitMask == ASTEROID_CATEGORY) {
		SKLabelNode *label = [[SKLabelNode alloc] init];
		[label setText:@"collided with asteroid"];
		[label setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
		while (true) {}
	}
}
-(void)createDPad {
    //Connect the images to the sprites.
    self.upButtonSprite = [SKSpriteNode spriteNodeWithImageNamed:@"Arrow"];
    self.downButtonSprite = [SKSpriteNode spriteNodeWithImageNamed:@"Arrow"];
    self.leftButtonSprite = [SKSpriteNode spriteNodeWithImageNamed:@"Arrow"];
    self.rightButtonSprite = [SKSpriteNode spriteNodeWithImageNamed:@"Arrow"];
	float scale = 0.1;
	[self.upButtonSprite setScale:scale];
	[self.downButtonSprite setScale:scale];
    [self.leftButtonSprite setScale:scale];
    [self.rightButtonSprite setScale:scale];
    //Position the arrows in the bottom left corner.  Note where (0,0) is.
    [self.upButtonSprite setPosition:CGPointMake(41,75)];
    [self.downButtonSprite setPosition:CGPointMake(41,25)];
    [self.leftButtonSprite setPosition:CGPointMake(16,50)];
    [self.rightButtonSprite setPosition:CGPointMake(65,50)];
    
    
    //Rotate the arrows to point the right direction.
    [self.downButtonSprite setZRotation:M_PI];
    [self.leftButtonSprite setZRotation:M_PI_2];
    [self.rightButtonSprite setZRotation:-M_PI_2];
    
    //Add the sprites to the view.
    [self addChild:self.upButtonSprite];
    [self addChild:self.downButtonSprite];
    [self addChild:self.leftButtonSprite];
    [self addChild:self.rightButtonSprite];
	
	
}
-(void)didEvaluateActions{
    //Give the spaceship a maximum velocity so it doesn't accelerate crazy.
    double cur_velocity = sqrt(pow(self.playerSprite.physicsBody.velocity.dy,2)+pow(self.playerSprite.physicsBody.velocity.dx,2));
    float vDir = atan2(self.playerSprite.physicsBody.velocity.dy,self.playerSprite.physicsBody.velocity.dx);
    if(cur_velocity > MAX_VELOCITY){
        [self.playerSprite.physicsBody setVelocity:CGVectorMake(cos(vDir)*MAX_VELOCITY, sin(vDir)*MAX_VELOCITY)];
    }
}

-(void)spawnAsteroid {
    //Create a new Asteroid.
    Asteroid *asteroid = [Asteroid spriteNodeWithImageNamed:@"Asteroid"];
	
    [asteroid setScale:0.25];
    
    //Pick a random x-position to start at, and determine the height to start at.
    float randomXStartingPosition = (arc4random() % 280) + 50;
    [asteroid setPosition:CGPointMake(randomXStartingPosition, [UIScreen mainScreen].bounds.size.height+asteroid.size.height)];
    
    //Set the physics body properties.
    //Pick the velocity of the asteroid.
    float randomY = -((arc4random() % 20)/10.0f)-4.0;
    [asteroid setPhysicsBody:[SKPhysicsBody bodyWithCircleOfRadius:self.playerSprite.frame.size.width/3.0]];
    asteroid.physicsBody.usesPreciseCollisionDetection = YES;
    asteroid.physicsBody.categoryBitMask = ASTEROID_CATEGORY;
    asteroid.physicsBody.CollisionBitMask = ROCKET_CATEGORY;
    asteroid.physicsBody.ContactTestBitMask = 0;
    asteroid.physicsBody.Dynamic = YES;
    asteroid.physicsBody.LinearDamping = 0.0;
    
    [self.asteroids addObject:asteroid];
    [self addChild:asteroid];
    
    [asteroid.physicsBody applyImpulse:CGVectorMake(0.0, randomY)];
}
@end
