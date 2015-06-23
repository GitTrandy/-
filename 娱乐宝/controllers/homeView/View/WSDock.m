//
//  WSDock.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/10.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//自定制Dock的思路是什么呢
//UI分析：是一个UIView层上有UIButton按钮

#import "WSDock.h"
#import "WSBottomMenu.h"
#import "WSIconView.h"
#import "WSTabBar.h"

@interface WSDock()
@property (nonatomic,weak) WSIconView *icoView;
@property (nonatomic,weak) WSTabBar *tabBar;
@property (nonatomic,weak) WSBottomMenu *bottomMenu;
@end

@implementation WSDock
+ (instancetype)dock
{
    return [[self alloc] init];
    
}

- (WSIconView *)icoView{
    if (_icoView == nil) {
        WSIconView *iconView = [[WSIconView alloc] init];
        [self addSubview:iconView];
        self.icoView = iconView;
    }
    return _icoView;
}

- (WSTabBar *)tabBar
{
    if (_tabBar == nil) {
        WSTabBar *tabBar = [[WSTabBar alloc] init];
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    return _tabBar;
}

- (WSBottomMenu *)bottomMenu
{
    if (_bottomMenu == nil) {
        WSBottomMenu *bottomMenu = [[WSBottomMenu alloc] init];
        bottomMenu.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:bottomMenu];
        self.bottomMenu = bottomMenu;
    }
    return _bottomMenu;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


@end
