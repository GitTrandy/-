//
//  SKVerticalTabController.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKVerticalTabController : UIViewController

@property (nonatomic, retain) UIImage *tabBarBackgroundImage;
@property (nonatomic, assign, readonly) NSUInteger numberOfTabs;
@property (nonatomic, assign, readonly) NSInteger selectedTabIndex;
@property (nonatomic, retain, readonly) NSArray *tabItemArray;
@property (nonatomic, retain, readonly) NSArray *tabControllerArray;
@property (nonatomic, assign) CGFloat tabItemOffsetY; // The offset of the tab items in the Y-axis direction

- (id)initWithTabItems:(NSArray *)tabItems tabControllers:(NSArray *)tabControllers;
- (void)setSelectedTabIndex:(NSInteger)aSelectedTabIndex animated:(BOOL)animation;

@end
