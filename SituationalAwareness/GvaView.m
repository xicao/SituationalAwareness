//
//  GvaView.m
//  SituationalAwareness
//
//  Created by Xi Cao on 26/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GvaView.h"

@implementation GvaView

//---------------------------------------
#define WHITE_ZONE_WIDTH    744
#define WHITE_ZONE_HEIGHT   493
#define WHITE_ZONE_ORIGIN_X 140
#define WHITE_ZONE_ORIGIN_Y 165

//---------------------------------------
#define GRAY_ZONE_WIDTH     744
#define GRAY_ZONE_HEIGHT    65
#define GRAY_ZONE_ORIGIN_X  140
#define GRAY_ZONE_ORIGIN_Y  100

//---------------------------------------
#define GREEN_LABEL_WIDTH   62
#define GREEN_LABEL_HEIGHT  12

//---------------------------------------
#define LABEL_X             177
#define LABEL_GAP           87

@synthesize functionalAreaLabel = _funtionalAreaLabel;

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawRectAtPoint:(CGPoint)p withWidth:(CGFloat)width andHeight:(CGFloat)height inContext:(CGContextRef)context 
{
    UIGraphicsPushContext(context);
    
    CGContextBeginPath(context);
    CGContextAddRect(context, CGRectMake(p.x, p.y, width, height));
    
    CGContextDrawPath(context,kCGPathFillStroke);
    UIGraphicsPopContext();
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    [[UIColor whiteColor] setFill];
    [[UIColor blackColor] setStroke];
    
    // draw a white rectangle
    [self drawRectAtPoint:CGPointMake(WHITE_ZONE_ORIGIN_X, WHITE_ZONE_ORIGIN_Y) withWidth:WHITE_ZONE_WIDTH andHeight:WHITE_ZONE_HEIGHT inContext:context];
    
    [[UIColor grayColor] setFill];
    [[UIColor blackColor] setStroke];
    
    // draw two gray rectangles
    [self drawRectAtPoint:CGPointMake(GRAY_ZONE_ORIGIN_X, GRAY_ZONE_ORIGIN_Y) withWidth:GRAY_ZONE_WIDTH andHeight:GRAY_ZONE_HEIGHT inContext:context];
    [self drawRectAtPoint:CGPointMake(GRAY_ZONE_ORIGIN_X, GRAY_ZONE_ORIGIN_Y)  withWidth:GRAY_ZONE_WIDTH andHeight:GREEN_LABEL_HEIGHT inContext:context];
    
    // draw a few green labels
    CGPoint labelOrigin;
    labelOrigin.x = LABEL_X;
    labelOrigin.y = GRAY_ZONE_ORIGIN_Y;
    
    CGContextSetLineWidth(context, 1.0);
    [[UIColor greenColor] setFill];
    [[UIColor blackColor] setStroke];
    
    for (int i = 0; i < 8; i++) {
        if (i == self.functionalAreaLabel) {
            CGContextSetLineWidth(context, 3.0);
            [[UIColor yellowColor] setStroke];
        } else {
            CGContextSetLineWidth(context, 1.0);
            [[UIColor blackColor] setStroke];
        }
        
        [self drawRectAtPoint:labelOrigin withWidth:GREEN_LABEL_WIDTH andHeight:GREEN_LABEL_HEIGHT inContext:context];
        labelOrigin.x += LABEL_GAP;
    }
}

- (void)functionalAreaLabelSelected:(NSString *)label
{
    NSArray *title = [NSArray arrayWithObjects:@"SA",@"WPN",@"DEF",@"SYS",@"DRV",@"STR",@"COM",@"BMS",nil];
    
    if ([title indexOfObject:label] == NSNotFound) {
        self.functionalAreaLabel = 0;
    } else {
        self.functionalAreaLabel = [title indexOfObject:label];
    }
    
    [self setNeedsDisplay];
}

@end
