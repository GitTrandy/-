//
//  SKWebToolBarItem.h
//  SimpleKit
//
//  Created by SimpleKit on 12-7-19.
//  Copyright (c) 2012 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SKWebToolBarItemTypeWebTool,
    SKWebToolBarItemTypeButtonTool,
} SKWebToolBarItemType;

@protocol SKWebToolBarItemDelegate;

@interface SKWebToolBarItem : UIBarButtonItem <UIActionSheetDelegate> {
    SKWebToolBarItemType _toolType;
}

@property (nonatomic, assign) id<SKWebToolBarItemDelegate> delegate;
@property (nonatomic, retain) UIBarButtonItem *back;
@property (nonatomic, retain) UIBarButtonItem *forward;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController *)controller actionTitles:(NSArray *)actionTitles buttonTitles:(NSArray *)buttonTitles;
- (void)setToolType:(SKWebToolBarItemType)toolType;

@end

@protocol SKWebToolBarItemDelegate <NSObject>

@optional
- (void)webToolBar:(SKWebToolBarItem *)webTool buttonDidClickAtIndex:(NSInteger)index webToolBarType:(SKWebToolBarItemType)type;

@end
