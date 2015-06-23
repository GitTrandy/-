//
//  SKTextField.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKTextField : UIView

@property (nonatomic, retain, readonly) UITextField *textField;

@property (nonatomic, assign) UIView *movingView;
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) UITextBorderStyle borderStyle;
@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;
@property (nonatomic, retain) NSArray *cancelInteractionViews;
@property (nonatomic, assign) UIView *leftView;
@property (nonatomic, assign) CGFloat leftViewWidth;

- (void)addObserver;
- (void)removeObserver;

@end
