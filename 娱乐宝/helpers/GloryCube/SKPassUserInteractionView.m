//
//  SKPassUserInteractionView.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKPassUserInteractionView.h"

@interface SKPassUserInteractionView ()

@end

@implementation SKPassUserInteractionView
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_passInteractionRectArray release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (int i = 0; i < [_passInteractionRectArray count]; i++) {
        CGRect rect = [[_passInteractionRectArray objectAtIndex:i] CGRectValue];
        if (CGRectContainsPoint(rect, point)) {
            return NO;
        }
    }
    
    return [super pointInside:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark Public Methods

#pragma mark -
#pragma mark Delegate Methods

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// TODO: init data code
}

- (void)_initView {
	// TODO: init view code
}

@end
