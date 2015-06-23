//
//  SKAlertView.m
//  SimpleKit
//
//  Created by SimpleKit on 12-11-9.
//  Copyright (c) 2012年 SimpleKit. All rights reserved.
//

#import "SKAlertView.h"

@interface SKAlertView ()

- (void)initData;
- (void)initView;

@end

@implementation SKAlertView

#pragma mark -
#pragma mark Public Attribute
@synthesize isAnimation = _isAnimation;
@synthesize showTime = _showTime;

#pragma mark -
#pragma mark Private Attribute

#pragma mark -
#pragma mark Public Code

#pragma mark -
#pragma mark Delegate Code

#pragma mark -
#pragma mark Private Code
- (void)initData {
    //[self performSelector:@selector(dismissAlert) withObject:nil afterDelay:5];
}

- (void)initView {

}

- (void)dismissAlert {
    //NSLog(@">>> dismissAlert !!!");
    [self dismissWithClickedButtonIndex:0 animated:_isAnimation];
}

#pragma mark -
#pragma mark Super Code
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        //NSLog(@">>> SKAlertView init !!!");
        //[self initData];
        self.isAnimation = YES;
        self.showTime = 3;
    }
    return self;
}

- (void)show {
    [super show];
    [self performSelector:@selector(dismissAlert) withObject:nil afterDelay:_showTime];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
