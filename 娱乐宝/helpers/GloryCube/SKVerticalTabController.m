//
//  SKVerticalTabController.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKVerticalTabController.h"
#import "SKVerticalTabItem.h"

@interface SKVerticalTabController ()

@property (nonatomic, retain) NSMutableArray *tabsArray; // tab的数组
@property (nonatomic, retain) NSMutableArray *tabFramesArray; // tab的frame的数组
@property (nonatomic, retain) UIView *tabBar; // 垂直的tab条
// 在vertical tab controller上的vertical tab item的数组
@property (nonatomic, retain) NSArray *tabItemArray;
// 在vertical tab controller上的每个vertical tab item所对应的controller的数组
@property (nonatomic, retain) NSArray *tabControllerArray;
@property (nonatomic, retain) UIView *baseView; // 视图容器

@end

@implementation SKVerticalTabController
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_tabBarBackgroundImage release];
    [_tabItemArray release];
    [_tabControllerArray release];
    
    [_tabsArray release];
    [_tabFramesArray release];
    [_tabBar release];
    [_baseView release];
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        [self _initData];
    }
    return self;
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
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor redColor]];
    self.view.frame = self.view.bounds;
    
    
    // 垂直的tab条的背景图片
    self.tabBar = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 704)] autorelease];
    _tabBar.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    [self.view addSubview:_tabBar];
    UIView *backgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 44 - 5, 704)] autorelease];
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:_tabBarBackgroundImage];
    [_tabBar addSubview:backgroundView];
    
    //background color is the same color of tab when been selected.（背景色和tab被选中时的颜色相同）
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    
    if ([_tabsArray count] == 0) {
        SKVerticalTabItem *item = [[[SKVerticalTabItem alloc] initWithFrame:CGRectMake(0, 0, 44 - 5, 123)] autorelease];
        item.title = @"全部客户111";
        item.verticalTabController = self;
        item.index = 0;
        [_tabsArray addObject:item];
        
        item = [[[SKVerticalTabItem alloc] initWithFrame:CGRectMake(0, 123 - 10, 44 - 5, 123)] autorelease];
        item.title = @"VIP客户";
        item.verticalTabController = self;
        item.index = 1;
        [_tabsArray addObject:item];
        
        item = [[[SKVerticalTabItem alloc] initWithFrame:CGRectMake(0, 123 + 123 - 20, 44 - 5, 123)] autorelease];
        item.title = @"普通客户";
        item.verticalTabController = self;
        item.index = 2;
        [_tabsArray addObject:item];
    }
    
    [self _initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Public Methods
// 初始化
- (id)initWithTabItems:(NSArray *)tabItems tabControllers:(NSArray *)tabControllers {
    self = [super init];
    if (self) {
        [self _initData];
        
        self.tabItemArray = tabItems;
        self.tabControllerArray = tabControllers;
        
        for (SKVerticalTabItem *item in _tabItemArray) {
            [_tabsArray addObject:item];
            [item setVerticalTabController:self];
        }
        
    }
    return self;
}

// 设置索引号为aSelectedTabIndex的tab为选中状态
- (void)setSelectedTabIndex:(NSInteger)aSelectedTabIndex animated:(BOOL)animation {
    BOOL selectNewPage = aSelectedTabIndex != _selectedTabIndex; // 判断是否选择了一个新的tab
    
    _selectedTabIndex = aSelectedTabIndex;
    if (selectNewPage) {
        [_baseView addSubview:[[_tabControllerArray objectAtIndex:[[_tabsArray objectAtIndex:_selectedTabIndex] itemID]] view]];
    }
    
    // tabs before the selected are added in sequence from the first to the selected;（将当前选中的那个tab之前的所有tab重新布局以及设置为未选中状态，并且保证当前选中的tab在最外层）
    for (NSInteger tabIndex = 0; tabIndex < _selectedTabIndex; tabIndex++) {
        NSValue *tabFrameValue = [_tabFramesArray objectAtIndex:tabIndex];
        CGRect tabFrame = [tabFrameValue CGRectValue];
        SKVerticalTabItem *tab = [_tabsArray objectAtIndex:tabIndex];
        if (animation) {
            [UIView beginAnimations:nil context:nil];
            tab.frame = tabFrame;
            [tab setSelected:NO];
            [UIView commitAnimations];
        } else {
            tab.frame = tabFrame;
            [tab setSelected:NO];
        }
        [_tabBar addSubview:tab];
    }
    
    //tabs after the selected are added in sequence from the last to the selected; （将当前选中的tab及其后的所有tab重新设置frame并且设置是否选中，并且保证当前选中的tab在最外层）
    for (NSInteger tabIndex = (self.numberOfTabs - 1); tabIndex >= _selectedTabIndex; tabIndex--) {
        SKVerticalTabItem *tab = [_tabsArray objectAtIndex:tabIndex];
        if (self.selectedTabIndex == tabIndex) {
            [tab setSelected:YES];
        } else {
            [tab setSelected:NO];
        }
        NSValue *tabFrameValue = [_tabFramesArray objectAtIndex:tabIndex];
        CGRect tabFrame = [tabFrameValue CGRectValue];
        if (animation) {
            [UIView beginAnimations:nil context:nil];
            tab.frame = tabFrame;
            [UIView commitAnimations];
        } else {
            tab.frame = tabFrame;
        }
        [_tabBar addSubview:tab];
    }
}

- (NSUInteger)numberOfTabs
{
	return [self.tabsArray count];
}

#pragma mark -
#pragma mark Delegate Methods

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// tab条的背景图片
    self.tabBarBackgroundImage = [UIImage imageNamed:@"sk_vertical_tab_bg"];
    self.tabsArray = [NSMutableArray arrayWithCapacity:0]; // tab的数组
    self.tabFramesArray = [NSMutableArray arrayWithCapacity:0]; // tab的frame的数组
//    self.tabHeight = 123; // tab的高度
    self.baseView = [[[UIView alloc] initWithFrame:CGRectMake(44, 0, 1024 - 44, 704)] autorelease];
    _selectedTabIndex = -1;
    self.tabItemOffsetY = 0;
}

- (void)_initView {
    [self.view addSubview:_baseView];
    
	for (int i = 0; i < [_tabsArray count]; i++) {
        SKVerticalTabItem *item = [_tabsArray objectAtIndex:i];
        UIPanGestureRecognizer *panGesture = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePanGuesture:)] autorelease];
        [item addGestureRecognizer:panGesture];
    }
    
    [self _caculateFrame];
    
    if ([self.tabsArray count]) {
        [self setSelectedTabIndex:0 animated:NO];
    }
    
    // 使视图背景与垂直tab的背景色保持一致
    for (int i = 0; i < [_tabControllerArray count]; i++) {
        UIViewController *c = [_tabControllerArray objectAtIndex:i];
        [c.view setBackgroundColor:[UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1]];
    }
}

// 处理pan手势
- (void)_handlePanGuesture:(UIPanGestureRecognizer *)sender {
    SKVerticalTabItem *panTab = (SKVerticalTabItem *)sender.view;
    NSUInteger panPosition = [self.tabsArray indexOfObject:panTab]; // 手势触发的tab在数组中的索引号
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self setSelectedTabIndex:panPosition animated:NO];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint position = [sender translationInView:_tabBar]; // sender每次移动的大小（分为x方向和y方向）
        
//        NSLog(@"position: %@", NSStringFromCGPoint(position));
        
        CGPoint center = CGPointMake(sender.view.center.x, sender.view.center.y + position.y); // sender移动之后移动视图的中心点位置
        
//        NSLog(@"center: %@", NSStringFromCGPoint(center));
        
        // Don't move the tab out of the tabview（不要将tab移出tabView）
        if (center.y < _tabBar.bounds.size.height - 5  &&  center.y > 5) {
            sender.view.center = center;
            [sender setTranslation:CGPointZero inView:_tabBar]; // ??? 如果这个不设置会怎么样，设置这个的效果是什么(每次循环之后，重置拖动的偏移量)
            CGFloat height = panTab.bounds.size.height;
            // If more than half the tab width is moved, exchange the positions（如果移动距离超过tab的一般宽度，就交换他们的位置）
            
//            SKLog(@"center: %@", NSStringFromCGPoint(center));
//            SKLog(@"%f", abs(center.y - height * panPosition - height / 2));
            
            if (abs(center.y - (height * panPosition - 15 * panPosition/*这里 - panPosition * 15 是为了偿还之前在计算tab的frame时，设置的overlapHeight导致的位置偏移*/) - _tabItemOffsetY - height / 2) > height / 2) {
                NSUInteger nextPos = position.y > 0 ? panPosition + 1 : panPosition - 1; // tab移动到的下一个位置的索引号
                if (nextPos >= self.numberOfTabs)
                    return;
                
                SKVerticalTabItem *nextTab = [self.tabsArray objectAtIndex:nextPos]; // 当前tab即将被移动到的那个索引号上的原来的tab
                if (nextTab) {
                    if (_selectedTabIndex == panPosition)
                        _selectedTabIndex = nextPos;
                    [self.tabsArray exchangeObjectAtIndex:panPosition withObjectAtIndex:nextPos];
                    
                    for (int i = 0; i < [_tabsArray count]; i++) {
                        SKVerticalTabItem *tab = [_tabsArray objectAtIndex:i];
                        tab.index = i;
                        tab.selected = NO;
                        if (i == _selectedTabIndex) {
                            tab.selected = YES;
                        }
                    }
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        
//                        NSLog(@"=== %f", height * panPosition + 0 + _tabItemOffsetY);
                        
                        nextTab.frame = CGRectMake(0, height * panPosition + 0 + _tabItemOffsetY - panPosition * 15/*这里 - panPosition * 15 是为了偿还之前在计算tab的frame时，设置的overlapHeight导致的位置偏移*/, panTab.bounds.size.width, panTab.bounds.size.height);
                    }];
                }
            }
        }
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            panTab.center = CGPointMake(panTab.center.x, panTab.center.y);
            [self setSelectedTabIndex:_selectedTabIndex animated:YES];
        }];
    }
}

// 处理tap手势
- (void)_handleTapGuesture:(UITapGestureRecognizer *)sender {
    UIView *sendView = sender.view;
    SKVerticalTabItem *tab = nil;
    if ([sendView isKindOfClass:SKVerticalTabItem.class]) {
        tab = (SKVerticalTabItem *)sendView;
    }
    
    if (tab) {
        NSInteger index = [_tabsArray indexOfObject:tab];
        [self setSelectedTabIndex:index animated:YES];
    }
}

// 计算frame
- (void)_caculateFrame
{
    const float overlapHeight = 15;
    CGFloat top = _tabItemOffsetY;
    
    [_tabFramesArray removeAllObjects];
    
    for (NSInteger tabIndex = 0; tabIndex < self.numberOfTabs; tabIndex++) {
        CGFloat tabHeight = [[_tabsArray objectAtIndex:tabIndex] height];
        CGRect tabFrame = CGRectMake(0, top, _tabBar.bounds.size.width - 5, tabHeight);
        [_tabFramesArray addObject:[NSValue valueWithCGRect:tabFrame]];
        top += (tabHeight - overlapHeight);
    }
}

@end
