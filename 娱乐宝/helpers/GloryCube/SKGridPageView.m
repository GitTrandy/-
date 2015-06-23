//
//  SKGridPageView.m
//  SimpleKit
//
//  Created by SimpleKit on 12-6-12.
//  Copyright (c) 2012年 SimpleKit. All rights reserved.
//

#import "SKGridPageView.h"
#import "SKUtil.h"

@interface SKGridPageView ()

@property (nonatomic, retain) UIView *view1;
@property (nonatomic, retain) UIView *view2;
@property (nonatomic, assign) NSInteger totalNumberOfPages;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, retain) UIColor *cellBorderColor;
@property (nonatomic, assign) CGRect gridContentRect;
@property (nonatomic, retain) UIView *content1;
@property (nonatomic, retain) UIView *content2;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, retain) UIPageControl *topPageControl;
@property (nonatomic, retain) UIPageControl *bottomPageControl;

- (void)initData;
- (void)initView;
- (void)clickedRightButton:(UIButton *)button;
- (void)clickedLeftButton:(UIButton *)button;
- (void)swipGesture:(UISwipeGestureRecognizer *)swip;
- (void)clickedCellButton:(UIButton *)button;
- (void)addButtonToContentViewWithIndex:(NSInteger)index;

@end

@implementation SKGridPageView

@synthesize view1 = _view1;
@synthesize view2 = _view2;
@synthesize totalNumberOfPages = _totalNumberOfPages;
@synthesize cellWidth = _cellWidth;
@synthesize cellHeight = _cellHeight;
@synthesize cellBorderColor = _cellBorderColor;
@synthesize gridContentRect = _gridContentRect;
@synthesize content1 = _content1;
@synthesize content2 = _content2;
@synthesize pageIndex = _pageIndex;
@synthesize topPageControl = _topPageControl;
@synthesize bottomPageControl = _bottomPageControl;

@synthesize delegate = _delegate;
@synthesize numberPerRow = _numberPerRow;
@synthesize numberPerColumn = _numberPerColumn;
@synthesize totalNumberOfCells = _totalNumberOfCells;
@synthesize animationTime = _animationTime;

#pragma mark -
#pragma mark Public Code

#pragma mark -
#pragma mark Delegate Code

#pragma mark -
#pragma mark Private Code
- (void)initData {
    self.backgroundColor = [UIColor clearColor];
    self.numberPerRow = 3;
    self.numberPerColumn = 3;
    self.totalNumberOfCells = 25;
    self.pageIndex = 0;
    self.animationTime = 0.75f;
}

- (void)initView {
    CGRect rect;
    UIButton *button;
    UIImage *img;
    UIView *view;
    UIColor *color;
    
    self.totalNumberOfPages = (_totalNumberOfCells + (_numberPerRow * _numberPerColumn) - 1) / (_numberPerRow * _numberPerColumn);
    
    [SKUtil borderWithView:self];
    
    // 上边
    img = [SKUtil imageFromBundleWithName:@"icon_pageUL" ofType:@"png"];
    rect = CGRectMake(0, 0, img.size.width, img.size.height);
    button = [[[UIButton alloc] initWithFrame:rect] autorelease];
    [button addTarget:self action:@selector(clickedLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [self addSubview:button];
    
    rect = CGRectMake(img.size.width, 0, self.bounds.size.width - img.size.width * 2, img.size.height);
    view = [[[UIView alloc] initWithFrame:rect] autorelease];
    img = [SKUtil imageFromBundleWithName:@"icon_pageUM" ofType:@"png"];
    color = [UIColor colorWithPatternImage:img];
    view.backgroundColor = color;
    [self addSubview:view];
    // Add pageControl to the top View
    self.topPageControl = [[[UIPageControl alloc] initWithFrame:view.bounds] autorelease];
    _topPageControl.backgroundColor = [UIColor clearColor];
    _topPageControl.userInteractionEnabled = NO;
    _topPageControl.numberOfPages = _totalNumberOfPages;
    _topPageControl.defersCurrentPageDisplay = YES;
    [view addSubview:_topPageControl];
    
    img = [SKUtil imageFromBundleWithName:@"icon_pageUR" ofType:@"png"];
    rect = CGRectMake(self.bounds.size.width - img.size.width, 0, img.size.width, img.size.height);
    button = [[[UIButton alloc] initWithFrame:rect] autorelease];
    [button addTarget:self action:@selector(clickedRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [self addSubview:button];
    
    // 下边
    img = [SKUtil imageFromBundleWithName:@"icon_pageDL" ofType:@"png"];
    rect = CGRectMake(0, self.bounds.size.height - img.size.height, img.size.width, img.size.height);
    button = [[[UIButton alloc] initWithFrame:rect] autorelease];
    [button addTarget:self action:@selector(clickedLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [self addSubview:button];
    
    rect = CGRectMake(img.size.width, self.bounds.size.height - img.size.height, self.bounds.size.width - img.size.width * 2, img.size.height);
    view = [[[UIView alloc] initWithFrame:rect] autorelease];
    img = [SKUtil imageFromBundleWithName:@"icon_pageDM" ofType:@"png"];
    color = [UIColor colorWithPatternImage:img];
    view.backgroundColor = color;
    [self addSubview:view];
    
    // Add pageControl to the bottom view
    self.bottomPageControl = [[[UIPageControl alloc] initWithFrame:view.bounds] autorelease];
    _bottomPageControl.backgroundColor = [UIColor clearColor];
    _bottomPageControl.userInteractionEnabled = NO;
    _bottomPageControl.numberOfPages = _totalNumberOfPages;
    _bottomPageControl.defersCurrentPageDisplay = YES;
    [view addSubview:_bottomPageControl];
    
    img = [SKUtil imageFromBundleWithName:@"icon_pageDR" ofType:@"png"];
    rect = CGRectMake(self.bounds.size.width - img.size.width, self.bounds.size.height - img.size.height, img.size.width, img.size.height);
    button = [[[UIButton alloc] initWithFrame:rect] autorelease];
    [button addTarget:self action:@selector(clickedRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [self addSubview:button];
    
    // 中间显示内容
    rect = CGRectMake(0, img.size.height, self.bounds.size.width, self.bounds.size.height - img.size.height * 2);
    self.view1 = [[[UIView alloc] initWithFrame:rect] autorelease];
    //_view1.backgroundColor = [UIColor blueColor];
    [self addSubview:_view1];
    
    self.view2 = [[[UIView alloc] initWithFrame:rect] autorelease];
    //_view2.backgroundColor = [UIColor redColor];
    _view2.hidden = YES;
    [self addSubview:_view2];
    
    // Add Gesture to _view1
    UISwipeGestureRecognizer *swip;
    swip = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)] autorelease];
    [swip setDirection:UISwipeGestureRecognizerDirectionRight];
    [_view1 addGestureRecognizer:swip];
    
    swip = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)] autorelease];
    [swip setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_view1 addGestureRecognizer:swip];
    
    // Add Gesture to _view2
    swip = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)] autorelease];
    [swip setDirection:UISwipeGestureRecognizerDirectionRight];
    [_view2 addGestureRecognizer:swip];
    
    swip = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)] autorelease];
    [swip setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_view2 addGestureRecognizer:swip];
    
    // Add the content of grid
    _cellWidth = self.bounds.size.width / _numberPerRow;
    _cellHeight = (self.bounds.size.height - img.size.height * 2) / _numberPerColumn;
    
    self.cellBorderColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
    self.gridContentRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    // Add views for _view1
    self.content1 = [[[UIView alloc] initWithFrame:_gridContentRect] autorelease];
    for (int i = 0; i < _numberPerRow; i++) {
        for (int j = 0; j < _numberPerColumn; j++) {
            rect = CGRectMake(j * _cellWidth, i * _cellHeight, _cellWidth, _cellHeight);
            button = [[[UIButton alloc] initWithFrame:rect] autorelease];
            //button.backgroundColor = [UIColor blueColor];
            [button addTarget:self
                       action:@selector(clickedCellButton:)
             forControlEvents:UIControlEventTouchUpInside];
            [SKUtil borderWithView:button color:_cellBorderColor];
            NSInteger index1 = i * _numberPerRow + j;
            button.tag = index1;
            if (index1 < _totalNumberOfCells) {
                [_content1 addSubview:button];
            }
            
            rect = CGRectMake(0, 0, rect.size.width, rect.size.height);
            UIView *view = [_delegate gridPage:self viewForCellAtIndex:i * _numberPerRow + j cellRect:rect];
            if (view) {
                view.userInteractionEnabled = NO;
                view.exclusiveTouch = NO;
                [button addSubview:view];
                
                //NSLog(@">>>view's index is %d", i * _numberPerRow + j);
            }
        }
    }
    [_view1 addSubview:_content1];
    
    // Add views for _view2
//    for (int i = 0; i < _numberPerRow; i++) {
//        for (int j = 0; j < _numberPerColumn; j++) {
//            rect = CGRectMake(j * _cellWidth, i * _cellHeight, _cellWidth, _cellHeight);
//            button = [[[UIButton alloc] initWithFrame:rect] autorelease];
//            button.backgroundColor = [UIColor redColor];
//            [button addTarget:self
//                       action:@selector(clickedCellButton:)
//             forControlEvents:UIControlEventTouchUpInside];
//            [SKUtil borderWithView:button color:_cellBorderColor];
//            [_view2 addSubview:button];
//        }
//    }
}

- (void)clickedRightButton:(UIButton *)button {
    
    ++_pageIndex;
    
    //NSLog(@">>> rightIndex: %d", _pageIndex % _totalNumberOfPages);
    //NSLog(@">>> _totalNumberOfPages: %d", _totalNumberOfPages);
    
    [self addButtonToContentViewWithIndex:_pageIndex];
    
    CATransition *transition = [CATransition animation];
    [transition setDuration:_animationTime];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transition setType:kCATransitionPush];
    [transition setSubtype:kCATransitionFromRight];
    [_view1.layer addAnimation:transition forKey:@"Push"];
    [_view2.layer addAnimation:transition forKey:@"Push"];
    _view1.hidden = !_view1.hidden;
    _view2.hidden = !_view2.hidden;
}

- (void)clickedLeftButton:(UIButton *)button {
    
    --_pageIndex;
    
    //NSLog(@">>> rightIndex: %d", _pageIndex % _totalNumberOfPages);
    //NSLog(@">>> _totalNumberOfPages: %d", _totalNumberOfPages);
    
    [self addButtonToContentViewWithIndex:_pageIndex];
    
    CATransition *transition = [CATransition animation];
    [transition setDuration:_animationTime];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [transition setType:kCATransitionPush];
    [transition setSubtype:kCATransitionFromLeft];
    [_view1.layer addAnimation:transition forKey:@"Push"];
    [_view2.layer addAnimation:transition forKey:@"Push"];
    _view1.hidden = !_view1.hidden;
    _view2.hidden = !_view2.hidden;
}

- (void)swipGesture:(UISwipeGestureRecognizer *)swip {
    
    //NSLog(@">>> 123");
    switch (swip.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        {
//            NSLog(@">>>Right");
            [self clickedLeftButton:nil];
        }
            break;
        case UISwipeGestureRecognizerDirectionLeft:
        {
//            NSLog(@">>>Left");
            [self clickedRightButton:nil];
        }
            break;
        default:
            break;
    }
}

- (void)clickedCellButton:(UIButton *)button {
//    NSLog(@">>> clickedCellButton !!! %i", button.tag);
}

- (void)addButtonToContentViewWithIndex:(NSInteger)index {
    
    index = (_totalNumberOfPages + index) % _totalNumberOfPages; // 用于处理index为-1和1时，能自动匹配上对应的页，当-1时index为2；当1时index为1
    _topPageControl.currentPage = index;
    _bottomPageControl.currentPage = index;
    
    NSLog(@"_topPageControl.currentPage: %i", _topPageControl.currentPage);
    
    if (_view2.hidden) {
        NSArray *views = [_content2 subviews];
        for (UIView *view in views) {
            
            NSArray *views1 = [view subviews];
            for (UIView *view in views1) {
                [view removeFromSuperview];
            }
            
            [view removeFromSuperview];
        }
        
        [_content2 removeFromSuperview];
        self.content2 = [[[UIView alloc] initWithFrame:_gridContentRect] autorelease];
        
        for (int i = 0; i < _numberPerRow; i++) {
            for (int j = 0; j < _numberPerColumn; j++) {
                CGRect rect = CGRectMake(j * _cellWidth, i * _cellHeight, _cellWidth, _cellHeight);
                UIButton *button = [[[UIButton alloc] initWithFrame:rect] autorelease];
                [SKUtil borderWithView:button color:_cellBorderColor];
                [_content2 addSubview:button];
                NSInteger index1 = (i * _numberPerRow + j) + (index % _totalNumberOfPages) * _numberPerRow * _numberPerColumn;
                button.tag = index1;
                
                //NSLog(@">>>index: %d", index1);
                if (index1 < _totalNumberOfCells) {
                    //button.backgroundColor = [UIColor redColor];
                    [button addTarget:self
                               action:@selector(clickedCellButton:)
                     forControlEvents:UIControlEventTouchUpInside];
                    
                    rect = CGRectMake(0, 0, rect.size.width, rect.size.height);
                    UIView *view = [_delegate gridPage:self viewForCellAtIndex:index1 cellRect:rect];
                    if (view) {
                        view.userInteractionEnabled = NO;
                        view.exclusiveTouch = NO;
                        [button addSubview:view];
                    }
                }
            }
        }
        
        [_view2 addSubview:_content2];
    } else {
        NSArray *views = [_content1 subviews];
        for (UIView *view in views) {
            [view removeFromSuperview];
        }
        
        [_content1 removeFromSuperview];
        self.content1 = [[[UIView alloc] initWithFrame:_gridContentRect] autorelease];
        
        for (int i = 0; i < _numberPerRow; i++) {
            for (int j = 0; j < _numberPerColumn; j++) {
                CGRect rect = CGRectMake(j * _cellWidth, i * _cellHeight, _cellWidth, _cellHeight);
                UIButton *button = [[[UIButton alloc] initWithFrame:rect] autorelease];
                [SKUtil borderWithView:button color:_cellBorderColor];
                [_content1 addSubview:button];
                NSInteger index1 = (i * _numberPerRow + j) + (index % _totalNumberOfPages) * _numberPerRow * _numberPerColumn;
                button.tag = index1;
                
                //NSLog(@">>>index: %d", index1);
                if (index1 < _totalNumberOfCells) {
                    //button.backgroundColor = [UIColor blueColor];
                    [button addTarget:self
                               action:@selector(clickedCellButton:)
                     forControlEvents:UIControlEventTouchUpInside];
                    
                    rect = CGRectMake(0, 0, rect.size.width, rect.size.height);
                    UIView *view = [_delegate gridPage:self viewForCellAtIndex:index1 cellRect:rect];
                    if (view) {
                        view.userInteractionEnabled = NO;
                        view.exclusiveTouch = NO;
                        [button addSubview:view];
                    }
                }
            }
        }
        
        [_view1 addSubview:_content1];
    }
}

#pragma mark -
#pragma mark Super Code
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
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    [self initView];
}

- (void)dealloc {
    [_view1 release];
    [_view2 release];
    [_cellBorderColor release];
    [_content1 release];
    [_content2 release];
    [_topPageControl release];
    [_bottomPageControl release];
    [super dealloc];
}

@end
