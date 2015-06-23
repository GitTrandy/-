//
//  SKTextField.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKTextField.h"
#import "SKUtil.h"

@interface SKTextField () <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, retain) UITextField *textField; // 是否考虑将textField属性作为只读属性对外提供，这样就不用再在此对象中设置textField的属性，而是直接通过此对象的textField属性设置textField的属性
@property (nonatomic, assign) BOOL isFocus;
@property (nonatomic, assign) CGRect fromFrame;
@property (nonatomic, assign) CGRect toFrame;
@property (nonatomic, assign) BOOL isKeyboardNotifyEvent; // 是否是否是由键盘监听产生的事件
@property (nonatomic, retain) UITapGestureRecognizer *tapRecognizer;

@end

@implementation SKTextField
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_textField release];
    [_tapRecognizer release];
    [_cancelInteractionViews release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self _initData];
    }
    return self;
}

- (void)layoutSubviews {
    [self _initView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark Public Methods
- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    
    CGFloat width = _leftViewWidth;
    if ([SKUtil floatValueOfCurrentDeviceVersion] < 6.0) {
        width = width - 15; // 15像素，是一个根据实际显示效果预估的差值
    } else {
        width = width - 15 + 8; // iOS6与以下版本的偏移相差8像素
    }
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.bounds.size.height)] autorelease];
    [view setBackgroundColor:[UIColor clearColor]];
    
//    CGPoint center = leftView.center;
//    center.y = view.center.y;
//    leftView.center = center;
    
    leftView.center = view.center;
    [view addSubview:leftView];
    
    [_textField setLeftView:view];
    [_textField setLeftViewMode:(UITextFieldViewModeAlways)];
}

#pragma mark -
#pragma mark Delegate Methods
#pragma mark UITextField Code
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    CGRect frame = _movingView.frame;
//    [UIView beginAnimations:@"textFieldShouldBeginEditing" context:nil];
//    [UIView setAnimationDuration:0.3f];
//    [UIView setAnimationCurve:(UIViewAnimationCurveEaseInOut)];
//    [_movingView setFrame:CGRectMake(0, -100, frame.size.width, frame.size.height)];
//    [UIView commitAnimations];
    
//    SKLog(@"");
    self.isFocus = YES;
//    [self _keyboardWillShow:nil]; // 用于处理弹出键盘之后，切换文本框没有发生移位的情况，所以需要在这里触发
    
    if (_isKeyboardNotifyEvent) { // 只有当收到键盘出现的事件时，才在切换输入框焦点的时候进行移位操作
        [UIView beginAnimations:@"textFieldShouldEndEditing" context:nil];
        [UIView setAnimationDuration:0.25f];
        [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
        [_movingView setFrame:_toFrame];
        [UIView commitAnimations];
    }
    
    [_movingView addGestureRecognizer:_tapRecognizer];
    
    return YES;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    CGRect frame = _movingView.frame;
//    [UIView beginAnimations:@"textFieldShouldEndEditing" context:nil];
//    [UIView setAnimationDuration:0.3f];
//    [UIView setAnimationCurve:(UIViewAnimationCurveEaseInOut)];
//    [_movingView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    [UIView commitAnimations];
//    
//    return YES;
//}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    SKLog(@"");
    self.isFocus = NO;
    
    [_movingView removeGestureRecognizer:_tapRecognizer];
}

#pragma mark UIGestureRecognizer Code
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isDescendantOfView:_textField]) {
        return NO;
    }
    
    NSMutableArray *tmpArray = [[_cancelInteractionViews copy] autorelease];
    for (UIView *v in tmpArray) {
        if ([touch.view isDescendantOfView:v]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// TODO: init data code
    self.textField = [[[UITextField alloc] initWithFrame:self.bounds] autorelease];
    [_textField setBorderStyle:(UITextBorderStyleRoundedRect)];
    [_textField setSecureTextEntry:NO];
    [_textField setClearButtonMode:(UITextFieldViewModeWhileEditing)];
    [_textField setAutocapitalizationType:(UITextAutocapitalizationTypeNone)];
    [_textField setDelegate:self];
    [_textField setContentVerticalAlignment:(UIControlContentVerticalAlignmentCenter)];
    [self setBackgroundColor:[UIColor clearColor]];
    self.tapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_actionForTapRecognizer:)] autorelease];
    [_tapRecognizer setDelegate:self];
    
    self.leftViewWidth = 40.0f;
}

- (void)_initView {
	// TODO: init view code
    [self addSubview:_textField];
    if (_borderStyle != UITextBorderStyleNone) {
        [_textField setBorderStyle:_borderStyle];
    }
    if (_secureTextEntry != NO) {
        [_textField setSecureTextEntry:_secureTextEntry];
    }
    if (_clearButtonMode != UITextFieldViewModeNever) {
        [_textField setClearButtonMode:_clearButtonMode];
    }
    self.fromFrame = _movingView.frame;
    self.toFrame = CGRectMake(_movingView.frame.origin.x, _movingView.frame.origin.y - fabsf(_offset), _movingView.frame.size.width, _movingView.frame.size.height);
}

- (void)_keyboardWillShow:(NSNotification *)notification {
//    SKLog(@"%d", _isFocus);
    
    self.isKeyboardNotifyEvent = YES;
    
    if (_isFocus) {
//        CGRect frame = _movingView.frame;
        
//        SKLog(@"frame: %@", NSStringFromCGRect(_toFrame));
        
//        NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//        SKLog(@"animationDuration: %f", animationDuration);
        [UIView beginAnimations:@"textFieldShouldBeginEditing" context:nil];
        [UIView setAnimationDuration:0.25f];
        [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
        [_movingView setFrame:_toFrame];
        [UIView commitAnimations];
    }
}

- (void)_keyboardWillHide:(NSNotification *)notification {
//    SKLog(@"%d", _isFocus);
    
    self.isKeyboardNotifyEvent = NO;
    
    if (_isFocus) {
//        CGRect frame = _movingView.frame;
        
//        SKLog(@"frame: %@", NSStringFromCGRect(_fromFrame));
        
//        NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//        SKLog(@"animationDuration: %f", animationDuration);
        [UIView beginAnimations:@"textFieldShouldEndEditing" context:nil];
        [UIView setAnimationDuration:0.25f];
        [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
        [_movingView setFrame:_fromFrame];
        [UIView commitAnimations];
    }
}

- (void)_actionForTapRecognizer:(UITapGestureRecognizer *)tap {
    [_textField resignFirstResponder];
}

@end
