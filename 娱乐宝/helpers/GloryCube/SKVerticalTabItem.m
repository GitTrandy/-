//
//  SKVerticalTabItem.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKVerticalTabItem.h"

@interface SKVerticalTabItem ()

@property (nonatomic, retain) UILabel *titleLabel; // 标题label
@property (nonatomic, retain) UIImageView *backgroundImage; // 背景图片视图
@property (nonatomic, assign) NSInteger itemID; // 此id一旦初始化之后就不再修改

@end

@implementation SKVerticalTabItem
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_selectedImage release]; // 选中时的图片
    [_normalImage release]; // 未选中时的图片
    [_titleFont release]; // 标题字体
    [_title release]; // 标题文字
    [_selectedTitleColor release]; // 选中时标题的颜色
    [_normalTitleColor release]; // 未选中时标题的颜色
    
    [_titleLabel release];
    [_backgroundImage release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [self _initData];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.subviews.count == 0) {
        [self _initView];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_verticalTabController setSelectedTabIndex:self.index animated:YES];
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
// 初始化
- (id)initWithTitle:(NSString *)title itemID:(NSInteger)itemID {
    self = [super init];
    /*
     实践证明：此处调用super的init之后，就会调用到self的initWithFrame方法，就像controller
     调用了siper的init之后，就会调用initWithNibName方法一样。所以self的_initData方法只能在
     一个初始化方法中调用，不能重复放在initWithFrame中。
     */
    if (self) {
        [self _initData];
        
        self.title = title;
        self.itemID = itemID;
        self.index = itemID;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    if (selected) {
        _titleLabel.textColor = _selectedTitleColor;
        _backgroundImage.image = _selectedImage;
        
    } else {
        _titleLabel.textColor = _normalTitleColor;
        _backgroundImage.image = _normalImage;
    }
}

//- (void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//    [_backgroundImage setFrame:self.bounds];
//}

#pragma mark -
#pragma mark Delegate Methods

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	self.selectedImage = [UIImage imageNamed:@"sk_vertical_tab_selected"];
    self.normalImage = [UIImage imageNamed:@"sk_vertical_tab_normal"];
    self.selected = NO;
    self.titleFont = [UIFont systemFontOfSize:14];
    self.title = @"null";
    self.normalTitleColor = [UIColor blackColor];
    self.selectedTitleColor = [UIColor blackColor];
    self.height = 123.0f;
    self.backgroundImage = [[[UIImageView alloc] init] autorelease];
    [_backgroundImage setImage:_normalImage];
    self.bgMarginLeft = 0;
    
    NSString *title = @"VIP";
    CGFloat labelWidth = [title sizeWithFont:_titleFont].width;
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(ceilf(fabsf((self.superview.bounds.size.width - labelWidth) / 2)), 0, labelWidth, _height)] autorelease];
    [_titleLabel setTextColor:_normalTitleColor];
}

- (void)_initView {
    
    CGRect rect = self.bounds;
    if (_bgMarginLeft > 0) {
        rect.origin.x = _bgMarginLeft;
        rect.size.width = rect.size.width - _bgMarginLeft;
    }
    [_backgroundImage setFrame:rect];
    [self addSubview:_backgroundImage];
    
    CGRect frame = _titleLabel.frame;
    frame.size.height = _height;
    [_titleLabel setFrame:frame];
    
    _titleLabel.text = _title;
    [_titleLabel setFont:_titleFont];
    [_titleLabel setNumberOfLines:100];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview:_titleLabel];
}

@end
