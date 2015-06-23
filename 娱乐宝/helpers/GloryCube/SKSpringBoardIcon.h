//
//  SKSpringBoardIcon.h
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol SKSpringBoardIconDelegate;

@interface SKSpringBoardIcon : UIView

@property (nonatomic, assign) id<SKSpringBoardIconDelegate> delegate;
@property (nonatomic, retain) UIImage *iconImage;
@property (nonatomic, copy) NSString *iconTitle;
@property (nonatomic, assign) CGRect iconImageRect; // Set the position of the icon image. Note: CGRectMake(the x coordinate of the upper left corner of the icon image，the y coordinate of the upper left corner of the icon image，the new width of icon image，the new height of icon image).
@property (nonatomic, assign) BOOL isShadow;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIColor *titleTextColor;
@property (nonatomic, retain) UIColor *titleShadowColor;

- (id)initWithOrigin:(CGPoint)origin iconImage:(UIImage *)iconImage iconTitle:(NSString *)iconTitle;
- (void)addTarget:(id)target actionForClick:(SEL)action;

@end

@protocol SKSpringBoardIconDelegate <NSObject>

@optional
- (void)didInitComponentsWithSpringBoardIcon:(SKSpringBoardIcon *)icon;

@end
