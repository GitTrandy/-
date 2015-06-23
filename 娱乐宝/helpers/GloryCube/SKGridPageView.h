//
//  SKGridPageView.h
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol SKGridPageViewDelegate;

@interface SKGridPageView : UIView

@property (nonatomic, assign) id<SKGridPageViewDelegate> delegate;
@property (nonatomic, assign) NSInteger numberPerRow;
@property (nonatomic, assign) NSInteger numberPerColumn;
@property (nonatomic, assign) NSInteger totalNumberOfCells;
@property (nonatomic, assign) CGFloat animationTime;

@end

@protocol SKGridPageViewDelegate <NSObject>

- (UIView *)gridPage:(SKGridPageView *)gridPage viewForCellAtIndex:(NSInteger)index cellRect:(CGRect)rect;

@end
