//
//  SKTopTabController.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKTopTabController.h"
#import "SKSegmentBar.h"
#import "SKSegmentBarItem.h"
#import "SKUtil.h"

@interface SKTopTabController () <SKSegmentBarDelegate, UIPopoverControllerDelegate>

// 要显示的 segment bar item 的数组
@property (nonatomic, retain, readwrite) NSArray *segmentBarItems;
// 点击segment bar item能切换的controller的数组
@property (nonatomic, retain, readwrite) NSArray *viewControllers;
// 内容视图
@property (nonatomic, retain, readwrite) UIView *contentView;
@property (nonatomic, retain) UIPopoverController *popover;
// 顶部的top bar视图
@property (nonatomic, retain) UIView *topBarView;
@property (nonatomic, assign) UIViewController *currentController;
@property (nonatomic, assign) BOOL isSetDefaultController;
/**
 *	@brief	当popover弹出的时候，popover会在显示的时候动态修改 创建navigation的controller的view的bounds的高度值，当在popover的navigation上使用过push之后，popover消失，这时就会出现：创建navigation的controller的view的bounds的高度值会一直为被修改过的值，而不能还原为它本来的值，所以在此处做这个变量来保存 创建navigation的controller的view 的bounds的值。为了解决popover的navigation在push之后，popover消失，导致下次弹出popover时高度发生不断叠加的改变的问题，我们在popover消失的时候，重新设置 创建navigation的controller的view 的bounds值即可解决此问题。
 */
@property (nonatomic, assign) CGRect popoverContentBounds;
@property (nonatomic, assign) NSInteger lastClickIndex; // 注意：这里这是点击的索引，而非select（选择）的索引

@property (nonatomic, strong) UIViewController* rightViewController;
@property (nonatomic, assign) CGRect contentRect;

@end

@implementation SKTopTabController
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_segmentBarItems release];
    [_viewControllers release];
    [_contentView release];
    [_topBarView release];
    [_popover release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [SKUtil forceLandscape];
    self.view.frame = self.view.bounds;
 
    if (!_viewControllers) {
        // 初始化controllers
        NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 6; i++) {
            UIViewController *controller = [[UIViewController alloc] init];
            UILabel *label = [[UILabel alloc] initWithFrame:_contentView.bounds];
            label.text = [NSString stringWithFormat:@"这是第 %d 个controller", i];
            label.backgroundColor = [UIColor grayColor];
            [controller.view addSubview:label];
            [controllers addObject:controller];
        }
        self.viewControllers = controllers;
    }
    
    if (!_segmentBarItems) {
        // 初始化segment bar item数组
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 6; i++) {
            SKSegmentBarItem *item = [[SKSegmentBarItem alloc] initWithFrame:CGRectMake(0 + i * 80, 0, 80, 44) type:(SKSegmentBarItemTypeSelect)];
            if (i == 0 || i == 1) {
                item = [[SKSegmentBarItem alloc] initWithFrame:CGRectMake(0 + i * 80, 0, 80, 44) type:(SKSegmentBarItemTypeClick)];
            }
            [item setBackgroundImage:[UIImage imageNamed:@"sk_top_tab_normal.png"] forState:(UIControlStateNormal)];
            [item setBackgroundImage:[UIImage imageNamed:@"sk_top_tab_selected.png"] forState:(UIControlStateSelected)];
            [items addObject:item];
        }
        self.segmentBarItems = items;
    }
    
    [self _initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIDeviceOrientationIsLandscape(toInterfaceOrientation);
}

//#else

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

//#endif

#pragma mark -
#pragma mark Public Methods
// 实例化方法
- (id)initWithSegmentBarItems:(NSArray *)items viewControllers:(NSArray *)controllers {
    self = [super init];
    if (self) {
        self.segmentBarItems = items;
        self.viewControllers = controllers;
        self.topBarView = [[[SKSegmentBar alloc] initWithFrame:CGRectMake(0, 0, 1024, 44) segmentBarItems:_segmentBarItems] autorelease];
        [_topBarView setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}

#pragma mark -
#pragma mark Delegate Methods
#pragma mark SKSegmentBar Code
- (void)segmentBar:(SKSegmentBar *)segmentBar didChangeItemAtIndex:(NSInteger)index {
    self.rightViewController=nil;
    [_currentController.view removeFromSuperview];
    UIView *v = [[_viewControllers objectAtIndex:index] view];
    v.frame = _contentView.bounds;
    [_contentView addSubview:v];
    self.currentController = [_viewControllers objectAtIndex:index];
}

- (void)segmentBar:(SKSegmentBar *)segmentBar didClickItemAtIndex:(NSInteger)index {
    UIViewController *c = [_viewControllers objectAtIndex:index];
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:c] autorelease];
    self.popover = [[[UIPopoverController alloc] initWithContentViewController:nav] autorelease];
    
    [_popover setDelegate:self];
    
//    c.popController = _pop;
    
    /*
     下方convertRect:后面一定要是view的bounds，如果为frame的话，转换过后得到的rect就会有
     frame的origin偏移，导致后面的显示位置出错。
     */
//    CGRect rect = [_contentView convertRect:[[_segmentBarItems objectAtIndex:index] bounds] fromView:[_segmentBarItems objectAtIndex:index]];
//    rect.origin.y = rect.origin.y - 10;
//    [_pop setPopoverContentSize:CGSizeMake(c.view.bounds.size.width, c.view.bounds.size.height + nav.navigationBar.bounds.size.height)];
//    [_pop presentPopoverFromRect:rect inView:_contentView permittedArrowDirections:(UIPopoverArrowDirectionAny) animated:NO];
    
//    SKLog(@"c.view.bounds: %@", NSStringFromCGRect(c.view.bounds));
    
    self.popoverContentBounds = c.view.bounds;
    self.lastClickIndex = index;
    
//    [SKUtil presentPopoverController:_popover fromView:[_segmentBarItems objectAtIndex:index] inView:_contentView popoverContentSize:CGSizeMake(c.view.bounds.size.width, c.view.bounds.size.height + nav.navigationBar.bounds.size.height) arrowDirections:(UIPopoverArrowDirectionUp)];
    
    [SKUtil presentPopoverController:_popover fromView:[_segmentBarItems objectAtIndex:index] inView:_contentView popoverContentSize:CGSizeMake(c.view.bounds.size.width, c.view.bounds.size.height + nav.navigationBar.bounds.size.height) arrowDirections:(UIPopoverArrowDirectionUp)];
}
- (void)setRightViewController:(UIViewController *)rightViewController{
    if (_rightViewController !=rightViewController) {
        if (!rightViewController) {
            UIView* view=_rightViewController.view;
            CGRect frame=view.frame;
            frame.origin.x=1024;
            [UIView animateWithDuration:0.5 delay:0.0f options:(UIViewAnimationOptionCurveLinear) animations:^{
                view.frame=frame;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }else{
            [_rightViewController.view removeFromSuperview];
        }
        _rightViewController=[rightViewController retain];
        _contentRect.origin.x=1024;
        _rightViewController.view.frame=_contentRect;
    }
}
- (void)showViewController:(UIViewController *)viewCtr inContentRect:(CGRect)contentRect;
{
    _contentRect=contentRect;
    self.rightViewController=viewCtr;
    
    UIView* v=_rightViewController.view;
    [_contentView addSubview:v];
    
    contentRect.origin.x=1024-contentRect.size.width;
    
    CGRect endRect = contentRect;
    
    [UIView animateWithDuration:0.5 delay:0.0f options:(UIViewAnimationOptionCurveLinear) animations:^{
            v.frame = endRect;
        } completion:^(BOOL finished) {
            
    }];
}
- (void)hideRightView{
    self.rightViewController=nil;
}
#pragma mark UIPopoverControllerDelegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    UIViewController *c = [_viewControllers objectAtIndex:_lastClickIndex];
    [c.view setBounds:_popoverContentBounds];
}

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	
}

- (void)_initView {
    self.contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 44, 1024, 768 - 20 - 44)] autorelease];
    [self.view addSubview:_contentView];
    
    [self _initTopTab];
}

- (void)_initTopTab {
    for (int i = 0; i < [_segmentBarItems count]; i++) {
        SKSegmentBarItem *item = [_segmentBarItems objectAtIndex:i];
        if (item.type == SKSegmentBarItemTypeSelect) {
            if (!_isSetDefaultController) {
                self.isSetDefaultController = YES;
                UIView *v = [[_viewControllers objectAtIndex:i] view];
                v.frame = _contentView.bounds;
                [_contentView addSubview:v];
                self.currentController = [_viewControllers objectAtIndex:i];
                break;
            }
        }
    }
    
    [(SKSegmentBar *)_topBarView setDelegate:self];
    [self.view addSubview:_topBarView];
}

- (void)_actionForClickSegmentBarItem:(SKSegmentBarItem *)item {
    
}

@end
