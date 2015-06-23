//
//  SKSegmentBarItem.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKSegmentBarItem.h"

@interface SKSegmentBarItem ()

// SKSegementBarItem的类型
@property (nonatomic, assign, readwrite) SKSegmentBarItemType type;

@end

@implementation SKSegmentBarItem
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initData];
    }
    return self;
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
// 根据 frame 和 type 初始化
- (id)initWithFrame:(CGRect)frame type:(SKSegmentBarItemType)type {
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self addTarget:self action:@selector(_actionForClickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

#pragma mark -
#pragma mark Delegate Methods

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	self.type = SKSegmentBarItemTypeClick;
}

- (void)_initView {
	// TODO: init view code
}

- (void)_actionForClickButton:(UIButton *)button {
    if (_type == SKSegmentBarItemTypeSelect) {
        [self setSelected:YES];
    }
}

@end
