//
//  SKHistoryTextField.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SKHistoryTextFieldOrderStyle {
    SKHistoryTextFieldOrderStyleASC = 0,
    SKHistoryTextFieldOrderStyleDESC
} SKHistoryTextFieldOrderStyle;

@protocol SKHistoryTextFieldDelegate;

@interface SKHistoryTextField : UIView

@property (nonatomic, assign) id<SKHistoryTextFieldDelegate> delegate;
@property (nonatomic, copy) NSString *historyTextFieldIdentifier; // Must set the property.
@property (nonatomic, assign) UIView *movingView; // Must set the property.
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, copy) NSString *historyListTitle;
@property (nonatomic, assign) CGFloat historyListTitleHeight;
@property (nonatomic, assign) CGFloat historyListHeight;
@property (nonatomic, retain, readonly) UITextField *textField;
@property (nonatomic, assign) UIView *leftView;
@property (nonatomic, assign) CGFloat leftViewWidth;
@property (nonatomic, assign) SKHistoryTextFieldOrderStyle orderStyle;
@property (nonatomic, retain) NSArray *cancelInteractionViews;

- (void)addObserver;
- (void)removeObserver;
- (void)addHistoryListWithInfo:(NSString *)info;

@end

@protocol SKHistoryTextFieldDelegate <NSObject>

@optional
- (BOOL)historyTextFieldShouldBeginEditing:(SKHistoryTextField *)textField;
- (void)historyTextFieldDidEndEditing:(SKHistoryTextField *)textField;
- (BOOL)historyTextField:(SKHistoryTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (BOOL)historyTextFieldShouldClear:(SKHistoryTextField *)textField;
- (BOOL)historyTextFieldShouldReturn:(SKHistoryTextField *)textField;

@end
