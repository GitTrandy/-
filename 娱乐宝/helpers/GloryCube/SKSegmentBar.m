//
//  SKSegmentBar.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKSegmentBar.h"
#import "SKSegmentBarItem.h"

@interface SKSegmentBar ()

// segment bar item 的数组
@property (nonatomic, retain, readwrite) NSArray *segmentBarItems;

@end

@implementation SKSegmentBar
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_segmentBarItems release];
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
// 根据 frame 和 items 初始化
- (id)initWithFrame:(CGRect)frame segmentBarItems:(NSArray *)items {
    self = [super initWithFrame:frame];
    if (self) {
        self.segmentBarItems = items;
        self.selectedIndex = -1;
        
        BOOL isSetDefaultSelect = NO;
        
        for (int i = 0; i < [items count]; i++) {
            SKSegmentBarItem *item = [items objectAtIndex:i];
            [item setShowsTouchWhenHighlighted:YES]; // 给按钮加上效果：A Boolean value that determines whether tapping the button causes it to glow.
            [self addSubview:item];
            if (item.type == SKSegmentBarItemTypeClick) {
                [item addTarget:self action:@selector(_actionForClickSegmentBarItem:) forControlEvents:(UIControlEventTouchUpInside)];
            } else if (item.type == SKSegmentBarItemTypeSelect) {
                [item addTarget:self action:@selector(_actionForClickSegmentBarItem:) forControlEvents:(UIControlEventTouchUpInside)];
                if (!isSetDefaultSelect) {
                    isSetDefaultSelect = YES;
                    NSInteger index = [_segmentBarItems indexOfObject:item];
                    self.selectedIndex = index;
                    [item setSelected:YES];
                }
            }
        }
    }
    return self;
}

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

- (void)_actionForClickSegmentBarItem:(SKSegmentBarItem *)item {
    if (item.type == SKSegmentBarItemTypeSelect) {
        for (SKSegmentBarItem *item in _segmentBarItems) {
            [item setSelected:NO];
        }
        [item setSelected:YES];
        
        NSInteger index = [_segmentBarItems indexOfObject:item];
        if (_selectedIndex != index) {
            if ([_delegate respondsToSelector:@selector(segmentBar:didChangeItemAtIndex:)]) {
                [_delegate segmentBar:self didChangeItemAtIndex:index];
            }
        }
        self.selectedIndex = index;
    } else if (item.type == SKSegmentBarItemTypeClick) {
        NSInteger index = [_segmentBarItems indexOfObject:item];
        if ([_delegate respondsToSelector:@selector(segmentBar:didClickItemAtIndex:)]) {
            [_delegate segmentBar:self didClickItemAtIndex:index];
        }
    }
}

@end
