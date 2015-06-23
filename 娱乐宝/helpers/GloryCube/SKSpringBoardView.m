//
//  SKSpringBoardView.m
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012年 SimpleKit. All rights reserved.
//

#import "SKSpringBoardView.h"

@interface SKSpringBoardIcon ()

@property (nonatomic, assign) CGFloat iconFrameWidth;
@property (nonatomic, assign) CGFloat iconFrameHeight;

@end

// 组件上icon的宽度
static const CGFloat kIconWidth = 192;
// 组件上icon的高度
static const CGFloat kIconHeight = 110;
// 组件上icon垂直方向上的间隔距离
static const CGFloat kIconVerticalGap = 32;
static const CGFloat kPageControlHeight = 36;

@interface SKSpringBoardView ()

// 此组件上左上角开始布局icon的初始位置：x
@property (nonatomic, assign) CGFloat iconsPositionX;
// 此组件上左上角开始布局icon的初始位置：y
@property (nonatomic, assign) CGFloat iconsPositionY;
// 组件上所有图标的行数
@property (nonatomic, assign) NSInteger numberOfRows;
// 组件上所有图标的列数
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, assign) NSInteger currentPage;

- (void)initData;
- (void)initView;

@end

@implementation SKSpringBoardView

@synthesize currentPage = _currentPage;

#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    [_backgroundImage release];
    [_mainView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initData];
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
- (void)reloadView {
    [_mainView removeFromSuperview];
    if ([_mainView isKindOfClass:[SKScrollPageView class]]) {
        _currentPage = [(SKScrollPageView *)_mainView currentPage];
    }
    [self initView];
}

//- (void)setCurrentPage:(NSInteger)currentPage {
//    _currentPage = currentPage;
//    if (_mainView != nil && [_mainView respondsToSelector:@selector(setCurrentPage:)]) {
//        [(SKScrollPageView *)_mainView setCurrentPage:currentPage];
//    }
//}
//
//- (NSInteger)currentPage {
//    if (_mainView != nil && [_mainView respondsToSelector:@selector(currentPage)]) {
//        _currentPage = [(SKScrollPageView *)_mainView currentPage];
//    }
//    return _currentPage;
//}

#pragma mark -
#pragma mark Delegate Methods
- (NSInteger)numberOfPagesInScrollPageView:(SKScrollPageView *)scrollPageView {
    NSInteger numberOfIcons = 0;
    if ([_delegate respondsToSelector:@selector(numberOfIconsInSpringBoard:)]) {
        numberOfIcons = [_delegate numberOfIconsInSpringBoard:self];
    }
    
    if (((int)_numberOfRows * _numberOfColumns) == 0) { // 防止分母为零的异常
        return 0;
    }
    
    return ((int)(numberOfIcons + _numberOfRows * _numberOfColumns - 1)) / ((int)_numberOfRows * _numberOfColumns);
}

- (UIView *)scrollPageView:(SKScrollPageView *)scrollPageView viewForPageIndex:(NSInteger)index {
    
//    UILabel *label = [[[UILabel alloc] init] autorelease];
//    [label setUserInteractionEnabled:YES];
//    [label setText:[NSString stringWithFormat:@"Page %d", index]];
    
    UIView *label = [[[UIView alloc] init] autorelease];
    [label setUserInteractionEnabled:YES];
    
    //    SKSpringBoardIcon *icon = [[[SKSpringBoardIcon alloc] initWithOrigin:CGPointMake(90, 40) iconImage:[UIImage imageNamed:@"im_home_bg.png"] iconTitle:@"这是这个icon的显示标题这是这个icon的显示标题"] autorelease];
    //    [label addSubview:icon];
    
    for (int i = 0; i < _numberOfRows * _numberOfColumns; i++) {
        NSInteger tag = index * _numberOfRows * _numberOfColumns + i;
        
        NSInteger numberOfIcons = 0;
        if ([_delegate respondsToSelector:@selector(numberOfIconsInSpringBoard:)]) {
            numberOfIcons = [_delegate numberOfIconsInSpringBoard:self];
        }
        
        if (tag >= numberOfIcons) {
            break;
        }
        
        SKSpringBoardIcon *icon = nil;
        if ([_delegate respondsToSelector:@selector(springBoard:iconForIndexAtIndex:)]) {
            icon = [_delegate springBoard:self iconForIndexAtIndex:tag];
        }
        
        [icon setIconFrameWidth:_iconFrameWidth];
        [icon setIconFrameHeight:_iconFrameHeight];
        
//        [icon setCenter:CGPointMake((int)(_iconsPositionX + _iconFrameWidth * (i % _numberOfColumns) + (int)_iconFrameWidth / 2), (int)(_iconsPositionY + (_iconVerticalGap + _iconFrameHeight) * (i / _numberOfColumns) + (int)_iconFrameHeight / 2))];
        
        [icon setFrame:CGRectMake((int)(_iconsPositionX + _iconFrameWidth * (i % _numberOfColumns)), (int)(_iconsPositionY + (_iconVerticalGap + _iconFrameHeight) * (i / _numberOfColumns)), _iconFrameWidth, _iconFrameHeight)];
        
//        NSLog(@"--- %d", (int)(_iconsPositionX + _iconFrameWidth * (i % _numberOfColumns)));
        
        
//        = [[[SKSpringBoardIcon alloc] initWithOrigin:CGPointMake(32 + 192 * (i % 5), 50 + (32 + 110) * (i / 5)) iconImage:[UIImage imageNamed:@"im_home_bg.png"] iconTitle:@"这是这个icon的显示标题"] autorelease];
        [icon setTag:tag];
        [label addSubview:icon];
    }
    
    return label;
}

- (void)didInitComponentsWithScrollPageView:(SKScrollPageView *)scrollPage {
    [scrollPage setCurrentPage:_currentPage];
}

//- (void)scrollPageView:(SKScrollPageView *)scrollPageView didChangePageAtIndex:(NSInteger)page {

//}

#pragma mark -
#pragma mark Private Methods
- (void)initData {
    
    self.iconFrameWidth = kIconWidth;
    self.iconFrameHeight = kIconHeight;
    self.iconVerticalGap = kIconVerticalGap;
    self.pageControlHeight = kPageControlHeight;
    
    self.mainView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
}

- (void)initView {
    
    // 如果本组建的frame的size非常小，经过下面的运算self.numberOfRows为0 或者 self.numberOfColumns，这样也就不会显示图标了，保证了程序的健壮性
    self.numberOfRows = ((int)(self.bounds.size.height - _pageControlHeight)) / ((int)(_iconFrameHeight + _iconVerticalGap));
    self.numberOfColumns = ((int)self.bounds.size.width) / ((int)_iconFrameWidth);
    
//    NSLog(@"==== %@", [NSString stringWithFormat:@"%d, %d", _numberOfRows, _numberOfColumns]);
    
	self.iconsPositionX = (((int)self.bounds.size.width) % ((int)_iconFrameWidth)) / 2;
    self.iconsPositionY = (((int)(self.bounds.size.height - _pageControlHeight)) % ((int)(_iconFrameHeight + _iconVerticalGap)) + _iconVerticalGap) / 2;
    
	self.mainView = [[[SKScrollPageView alloc] initWithFrame:self.bounds] autorelease];
    [self insertSubview:_mainView atIndex:0];
    [(SKScrollPageView *)_mainView setBgImage:_backgroundImage];
    [(SKScrollPageView *)_mainView setDelegate:self];
    [(SKScrollPageView *)_mainView setBackgroundColor:self.backgroundColor];
}

/*
 给 view 添加边框
 */
+ (void) borderWithView:(UIView *)view {
	[[view layer] setBorderColor:[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f].CGColor];
	[[view layer] setBorderWidth:1];
	[[view layer] setMasksToBounds:YES];
	[[view layer] setCornerRadius:4];
}

@end
