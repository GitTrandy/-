//
//  SKSegmentBar.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKSegmentBarDelegate;

@interface SKSegmentBar : UIView

@property (nonatomic, assign) id<SKSegmentBarDelegate> delegate;
@property (nonatomic, retain, readonly) NSArray *segmentBarItems; // The array of segment bar items.
@property (nonatomic, assign) NSInteger selectedIndex;

- (id)initWithFrame:(CGRect)frame segmentBarItems:(NSArray *)items;

@end

@protocol SKSegmentBarDelegate <NSObject>

@optional
- (void)segmentBar:(SKSegmentBar *)segmentBar didChangeItemAtIndex:(NSInteger)index;
- (void)segmentBar:(SKSegmentBar *)segmentBar didClickItemAtIndex:(NSInteger)index;

@end
