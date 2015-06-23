//
//  SKSpringBoardIcon.m
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012年 SimpleKit. All rights reserved.
//

#import "SKSpringBoardIcon.h"

// 本视图的宽度
static const int kIconWidth = 192;
// 本视图的高度
static const int kIconHeight = 110;
// 本视图的固定大小
static const CGSize kIconSize = {192, 110};

static const int kIconImageViewWidth = 72;
static const int kIconImageViewHeight = 72;

@interface SKSpringBoardIcon ()

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, assign) BOOL isInnerInit;
@property (nonatomic, assign) CGFloat iconFrameWidth;
@property (nonatomic, assign) CGFloat iconFrameHeight;
@property (nonatomic, assign) CGSize iconSize;

- (void)initData;
- (void)initView;
- (void)clickedButton:(UIButton *)button;

@end

@implementation SKSpringBoardIcon

#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // Release code
    [_iconImage release];
    [_iconTitle release];
    
    [_button release];
    
    [_titleFont release];
    [_titleTextColor release];
    [_titleShadowColor release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        [self initData];
    }
    return self;
}

- (id)initWithOrigin:(CGPoint)origin iconImage:(UIImage *)iconImage iconTitle:(NSString *)iconTitle
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, kIconWidth, kIconHeight)];
    if (self) {
        // Initialization code
        [self initData];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        self.iconImage = iconImage;
        self.iconTitle = iconTitle;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    
//}

- (void)layoutSubviews {
    
    if ([self.subviews count] == 0) {
        [self initView];
    }
    
    [super layoutSubviews];
}

#pragma mark -
#pragma mark Public Methods
- (void)addTarget:(id)target actionForClick:(SEL)action {
    self.target = target;
    self.selector = action;
}

- (void)setIconImage:(UIImage *)iconImage {
    if (_iconImage != iconImage) {
        [_iconImage release];
        _iconImage = [iconImage copy];
        
        UIImage *img = _iconImage;
        // 如果设置了_iconImageRect
        if (!((int)_iconImageRect.origin.x == 0 && (int)_iconImageRect.origin.y == 0 && (int)_iconImageRect.size.width == 0 && (int)_iconImageRect.size.height == 0)) {
            // 缩放图片以适配按钮大小
            UIGraphicsBeginImageContext(CGSizeMake(72, 72));
            [_iconImage drawInRect:_iconImageRect];
            img = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        [_button setBackgroundImage:img forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark Delegate Methods

#pragma mark -
#pragma mark Private Methods
- (void)initData {
	self.isInnerInit = YES;
    self.iconFrameWidth = kIconWidth;
    self.iconFrameHeight = kIconHeight;
    self.iconSize = CGSizeMake(_iconFrameWidth, _iconFrameHeight);
    self.isShadow = YES;
    self.titleFont = [UIFont boldSystemFontOfSize:13];
    self.titleTextColor = [UIColor whiteColor];
    self.titleShadowColor = [UIColor grayColor];
}

- (void)initView {
    UILabel *label;
    UIView *aView;
    CGRect rect;
    
    //[SKSpringBoardIcon borderWithView:self];
    
    rect = CGRectMake((_iconFrameWidth - kIconImageViewWidth) / 2, 0, kIconImageViewWidth, kIconImageViewHeight);
    aView = [[UIView alloc] initWithFrame:rect];
    [aView setBackgroundColor:[UIColor clearColor]];
    
    rect = CGRectMake(0, 0, kIconImageViewWidth, kIconImageViewHeight);
    
    self.button = [[[UIButton alloc] initWithFrame:rect] autorelease];
    
    UIImage *img = _iconImage;
    // 如果设置了_iconImageRect
    if (!((int)_iconImageRect.origin.x == 0 && (int)_iconImageRect.origin.y == 0 && (int)_iconImageRect.size.width == 0 && (int)_iconImageRect.size.height == 0)) {
        // 缩放图片以适配按钮大小
        UIGraphicsBeginImageContext(CGSizeMake(72, 72));
        [_iconImage drawInRect:_iconImageRect];
        /*
         注意：下面的img不能使用_iconImage，如果使用_iconImage的话，self的_iconImage的内存管理就出现问题了，直接使用对_iconImage进行赋值，就没有经过内存管理，所以会导致内存错误，比如EXC_BAD_ACCESS错误
         */
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    [_button setBackgroundImage:img forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor whiteColor]];
    [_button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [_button setTag:self.tag];
    [[_button layer] setShouldRasterize:YES];
    //[[button layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
    [SKSpringBoardIcon borderWithView:_button cornerRadius:13];
    
    [aView addSubview:_button];
    [self insertSubview:aView atIndex:0];
    [aView release];
    
    if (_isShadow) {
        [[aView layer] setShouldRasterize:YES];
        //[[aView layer] setRasterizationScale:[[UIScreen mainScreen] scale]];
        [[aView layer] setShadowColor:[UIColor blackColor].CGColor];
        [[aView layer] setShadowOffset:CGSizeMake(0, 33)];
        [[aView layer] setShadowOpacity:0.283];
        [[aView layer] setShadowRadius:13];
    }
    
    rect = CGRectMake(9, kIconImageViewHeight + 9, _iconFrameWidth - 9 * 2, 30);
    label = [[UILabel alloc] initWithFrame:rect];
    [label setText:_iconTitle];
    [label setNumberOfLines:2];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:_titleFont];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:_titleShadowColor];
    [self insertSubview:label atIndex:1];
    [label release];
    
    rect = CGRectMake(9, kIconImageViewHeight + 8, _iconFrameWidth - 9 * 2, 30);
    label = [[UILabel alloc] initWithFrame:rect];
    [label setText:_iconTitle];
    [label setNumberOfLines:2];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:_titleFont];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:_titleTextColor];
    [self insertSubview:label atIndex:2];
    [label release];
    
    if ([_delegate respondsToSelector:@selector(didInitComponentsWithSpringBoardIcon:)]) {
        [_delegate didInitComponentsWithSpringBoardIcon:self];
    }
}

- (void)clickedButton:(UIButton *)button {
    //NSLog(@">>> clickedButton tag: %d", button.tag);
    
    if ([_target respondsToSelector:_selector]) {
        //NSLog(@"[_target respondsToSelector:_selector]");
        [_target performSelector:_selector withObject:self];
    }
}

/*
 给 view 添加边框
 */
+ (void)borderWithView:(UIView *)view {
	[[view layer] setBorderColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f].CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setMasksToBounds:YES];
	[[view layer] setCornerRadius:4];
}

+ (void)borderWithView:(UIView *)view cornerRadius:(CGFloat)radius {
	[[view layer] setBorderColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:0.5f].CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setMasksToBounds:YES];
	[[view layer] setCornerRadius:radius];
    //NSLog(@">>> borderWithView");
}

@end
