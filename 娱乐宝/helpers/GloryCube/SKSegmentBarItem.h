//
//  SKSegmentBarItem.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SKSegmentBarItemType {
    SKSegmentBarItemTypeClick = 0,
    SKSegmentBarItemTypeSelect
} SKSegmentBarItemType;

@interface SKSegmentBarItem : UIButton

@property (nonatomic, assign, readonly) SKSegmentBarItemType type;

- (id)initWithFrame:(CGRect)frame type:(SKSegmentBarItemType)type;

@end
