//
//  SKVerticalTabItem.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKVerticalTabController.h"

@interface SKVerticalTabItem : UIView

@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, retain) UIImage *normalImage;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UIColor *selectedTitleColor;
@property (nonatomic, retain) UIColor *normalTitleColor;
@property (nonatomic, assign) SKVerticalTabController *verticalTabController;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign, readonly) NSInteger itemID;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat bgMarginLeft;

- (id)initWithTitle:(NSString *)title itemID:(NSInteger)itemID;

@end
