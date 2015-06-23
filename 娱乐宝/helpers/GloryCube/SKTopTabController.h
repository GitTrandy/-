//
//  SKTopTabController.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTopTabController : UIViewController

@property (nonatomic, retain, readonly) NSArray *segmentBarItems;
@property (nonatomic, retain, readonly) NSArray *viewControllers;
@property (nonatomic, retain, readonly) UIView *contentView;
@property (nonatomic, retain, readonly) UIView *topBarView;
@property (nonatomic, retain, readonly) UIPopoverController *popover;

- (id)initWithSegmentBarItems:(NSArray *)items viewControllers:(NSArray *)controllers;
- (void)showViewController:(UIViewController *)viewCtr inContentRect:(CGRect)contentRect;
- (void)hideRightView;

@end
