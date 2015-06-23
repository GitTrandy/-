//
//  SKWebToolBarItem.m
//  SimpleKit
//
//  Created by SimpleKit on 12-7-19.
//  Copyright (c) 2012年 SimpleKit. All rights reserved.
//

#import "SKWebToolBarItem.h"

@interface SKWebToolBarItem () {
    BOOL _isActionSheetShowing;
}

@property (nonatomic, retain) UIToolbar *webTools;
@property (nonatomic, retain) UIToolbar *buttonTool;
@property (nonatomic, retain) NSArray *actionTitles;

- (void)initData;
- (void)initView;
- (void)action:(UIBarButtonItem *)item;

@end

@implementation SKWebToolBarItem

#pragma mark -
#pragma mark Public Properties
@synthesize delegate = _delegate;
@synthesize back = _back;
@synthesize forward = _forward;

#pragma mark -
#pragma mark Private Properties
@synthesize webTools = _webTools;
@synthesize buttonTool = _buttonTool;
@synthesize actionTitles = _actionTitles;

#pragma mark -
#pragma mark Public Code
- (void)dealloc {
    [_back release];
    [_forward release];
    [_webTools release];
    [_buttonTool release];
    [_actionTitles release];
    [super dealloc];
}

- (void)setToolType:(SKWebToolBarItemType)toolType {
    _toolType = toolType;
    switch (_toolType) {
        case SKWebToolBarItemTypeWebTool:
            _webTools.hidden = NO;
            _buttonTool.hidden = YES;
            break;
        case SKWebToolBarItemTypeButtonTool:
            _webTools.hidden = YES;
            _buttonTool.hidden = NO;
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark Delegate Code
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    _isActionSheetShowing = NO;
    if (buttonIndex >= 0) {
        if ([_delegate respondsToSelector:@selector(webToolBar:buttonDidClickAtIndex:webToolBarType:)]) {
            [_delegate webToolBar:self buttonDidClickAtIndex:buttonIndex + 3 webToolBarType:_toolType];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    _isActionSheetShowing = NO;
    NSLog(@"didDismissWithButtonIndex");
}

#pragma mark -
#pragma mark Private Code
- (void)initData {

}

- (void)initView {
    
}

- (void)action:(UIBarButtonItem *)item {
    switch (item.tag) {
        case 0:
        case 1:
        case 2:
        {
            if ([_delegate respondsToSelector:@selector(webToolBar:buttonDidClickAtIndex:webToolBarType:)]) {
                [_delegate webToolBar:self buttonDidClickAtIndex:item.tag webToolBarType:_toolType];
            }
        }
            break;
        case 3:
        {
            if (!_isActionSheetShowing) {
                UIActionSheet *sheet = [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil] autorelease];
                for (NSString *title in _actionTitles) {
                    [sheet addButtonWithTitle:title];
                }
                [sheet showFromBarButtonItem:item animated:YES];
                _isActionSheetShowing = YES;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark Super Code

- (id)initWithFrame:(CGRect)frame controller:(UIViewController *)controller actionTitles:(NSArray *)actionTitles buttonTitles:(NSArray *)buttonTitles
{
    self = [super init];
    if (self) {
        UIToolbar *toolBar = [[[UIToolbar alloc] initWithFrame:frame] autorelease];
        toolBar.tintColor = controller.navigationController.navigationBar.tintColor;
        toolBar.alpha = controller.navigationController.navigationBar.alpha;
        
        // 绘制后退按钮
        // create the bitmap context
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(nil, 27, 27, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
        CGColorSpaceRelease(colorSpace);
        // set the fill color
        CGColorRef fillColor = [UIColor blackColor].CGColor;
        CGContextSetFillColor(context, CGColorGetComponents(fillColor));
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 8.0f, 13.0f - 2);
        CGContextAddLineToPoint(context, 24.0f, 4.0f - 2);
        CGContextAddLineToPoint(context, 24.0f, 22.0f - 2);
        CGContextFillPath(context);
        // convert the context into a CGImageRef
        CGImageRef image = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        UIImage *img = [UIImage imageWithCGImage:image];
        CGImageRelease(image);
        
       self.back = [[[UIBarButtonItem alloc] initWithImage:img style:(UIBarButtonItemStylePlain) target:self action:@selector(action:)] autorelease];
        _back.tag = 0;
        self.forward = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemPlay) target:self action:@selector(action:)] autorelease];
        _forward.tag = 1;
        UIBarButtonItem *refresh = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(action:)] autorelease];
        refresh.tag = 2;
        UIBarButtonItem *action = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAction) target:self action:@selector(action:)] autorelease];
        action.tag = 3;
        UIBarButtonItem *space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil] autorelease];
        
        NSMutableArray *components = [NSMutableArray arrayWithCapacity:0];
        
//        UIBarButtonItem *leftButton1 = [[[UIBarButtonItem alloc] initWithTitle:@"列表更新" style:(UIBarButtonItemStyleBordered) target:nil action:nil] autorelease];
//        UIBarButtonItem *leftButton2 = [[[UIBarButtonItem alloc] initWithTitle:@"垫板下载" style:(UIBarButtonItemStyleBordered) target:nil action:nil] autorelease];
        
        //[components addObject:leftButton];
        //[components addObject:space];
        [components addObject:_back];
        [components addObject:space];
        [components addObject:_forward];
        [components addObject:space];
        [components addObject:refresh];
        [components addObject:space];
        [components addObject:action];
        [components addObject:space];
//        [components addObject:reLogin];
//        [components addObject:space];
        
        self.webTools = [[[UIToolbar alloc] initWithFrame:frame] autorelease];
        _webTools.items = components;
        [toolBar addSubview:_webTools];
        _webTools.hidden = NO;
        
        self.actionTitles = actionTitles;
        NSArray *titles = buttonTitles;
        NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:0];
        NSInteger tag = 0;
        for (NSString *title in titles) {
            UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithTitle:title style:(UIBarButtonItemStyleBordered) target:self action:@selector(action:)] autorelease];
            button.tag = tag++;
            [buttons addObject:button];
        }
        self.buttonTool = [[[UIToolbar alloc] initWithFrame:frame] autorelease];
        _buttonTool.items = buttons;
        [toolBar addSubview:_buttonTool];
        _buttonTool.hidden = YES;
        
        self.customView = toolBar;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
