//
//  SKTableView.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKTableView.h"
#import "SKTableViewCell.h"
#import "SKUtil.h"

@interface SKTableView () <UITableViewDelegate, UITableViewDataSource, SKTableViewCellDelegate>

@property (nonatomic, assign) NSInteger numberOfColumns;

@property (nonatomic, retain) NSMutableArray *columnWidthArray;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, retain) UIScrollView *scrollView;

@end

@implementation SKTableView
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_columnWidthArray release];
    [_scrollView release];
    [_headerBgImage release];
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
    [super layoutSubviews];
    [self setBackgroundColor:[UIColor clearColor]];
    
    /*
     如果这里需要添加子视图，并且这些子视图是在这里创建的或者通过委托得到的，就需要判断是否子视图的
     数量为某个值，如为0，这样才能防止重复创建视图添加到此对象上。
     */
    if ([self.subviews count] == 0) {
        [self _initView];
    }
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

#pragma mark -
#pragma mark Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(tableView:heightForRowIndex:)]) {
        _rowHeight = [_delegate tableView:self heightForRowIndex:indexPath.row];
    }
    return _rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_delegate numberOfRowsInTableView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    SKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[SKTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier] autorelease];
        [cell setColumnWidthArray:_columnWidthArray];
        [cell setDelegate:self];
    }
    
    if (!_clickable) {
        [cell setUserInteractionEnabled:NO];
    }
    
    NSArray *titles = @[
                        [NSString stringWithFormat:@"row%d, ----- column0", indexPath.row],
                        [NSString stringWithFormat:@"row%d, column1", indexPath.row],
                        [NSString stringWithFormat:@"row%d, column2", indexPath.row],
                        [NSString stringWithFormat:@"row%d, column3", indexPath.row],
                        [NSString stringWithFormat:@"row%d, column4", indexPath.row],
                        [NSString stringWithFormat:@"row%d, column5", indexPath.row],
                        [NSString stringWithFormat:@"row%d, column6", indexPath.row],
                        [NSString stringWithFormat:@"row%d, column7", indexPath.row]
                        ];
    
    if ([_delegate respondsToSelector:@selector(tableView:titlesForCellAtRowIndex:)]) {
        titles = [_delegate tableView:self titlesForCellAtRowIndex:indexPath.row];
    }
    
    [cell setTitleArray:titles];
    [cell setTag:indexPath.row];
    
//    [self _addViewToCell:cell atIndexPath:indexPath];
    
//    [cell.textLabel setText:[NSString stringWithFormat:@"row%d", indexPath.row]];
    
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableViewCell:(SKTableViewCell *)cell didClickAtRowIndex:(NSInteger)rowIndex columnIndex:(NSInteger)columnIndex {
//    SKLog(@"rowIndex: %d; columnIndex: %d", rowIndex, columnIndex);
    if ([_delegate respondsToSelector:@selector(tableView:didClickAtRowIndex:columnIndex:)]) {
        [_delegate tableView:self didClickAtRowIndex:rowIndex columnIndex:columnIndex];
    }
}

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// TODO: init data code
    self.numberOfColumns = 8;
    self.columnWidthArray = [NSMutableArray arrayWithCapacity:0];
    self.rowHeight = 40;
    self.clickable = YES;
}

- (void)_initView {
	// TODO: init view code
    UIImageView *imageView;
    UIView *v;
    UIButton *button;
    
    CGFloat headerHeight = 42;
    
    if ([_delegate respondsToSelector:@selector(heightForHeaderInTableView:)]) {
        headerHeight = [_delegate heightForHeaderInTableView:self];
    }
    
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, headerHeight + 8);
    
    if ([_delegate respondsToSelector:@selector(numberOfColumnsInTableView:)]) {
        self.numberOfColumns = [_delegate numberOfColumnsInTableView:self];
    }
    
    self.scrollView = [[[UIScrollView alloc] initWithFrame:self.bounds] autorelease];
    [self addSubview:_scrollView];
    
    // 标题视图
    UIView *titleView = [[[UIView alloc] initWithFrame:rect] autorelease];
    [_scrollView addSubview:titleView];
    [SKUtil borderWithView:titleView cornerRadius:8 masksToBounds:YES];
    if (!_clickable) {
        [titleView setUserInteractionEnabled:NO];
    }
    
    if (_headerBgImage == nil) {
        self.headerBgImage = [UIImage imageNamed:@"sk_table_title_bg"];
    }
    
    imageView = [[[UIImageView alloc] initWithFrame:rect] autorelease];
    [titleView addSubview:imageView];
    
    CGFloat offsetX = 0;
    for (int i = 0; i < _numberOfColumns; i++) {
        CGFloat width = self.bounds.size.width / 8;
        if ([_delegate respondsToSelector:@selector(tableView:widthForColumnIndex:)]) {
            width = [_delegate tableView:self widthForColumnIndex:i];
        }
        
        [_columnWidthArray addObject:[NSNumber numberWithFloat:width]];
        
        // 添加表头每列的交互对象
        rect = CGRectMake((offsetX), 0, width, headerHeight);
        if (i == _numberOfColumns - 1) {
            rect = CGRectMake((offsetX), 0, width, headerHeight);
        }
        
        button = [[[UIButton alloc] initWithFrame:rect] autorelease];
        [button setBackgroundImage:_headerBgImage forState:(UIControlStateNormal)];
        NSString *title = @"NULL";
        if ([_delegate respondsToSelector:@selector(tableView:titleForColumnIndex:)]) {
            title = [_delegate tableView:self titleForColumnIndex:i];
        }
        [button setTitle:title forState:(UIControlStateNormal)];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [titleView addSubview:button];
        
        // 加上标题的垂直分割线
        if (i != 0) {
            rect = CGRectMake((offsetX), 0, 1, rect.size.height);
            v = [[[UIView alloc] initWithFrame:rect] autorelease];
            [v setBackgroundColor:[UIColor darkGrayColor]];
//            [v.layer setShadowColor:[UIColor whiteColor].CGColor];
//            [v.layer setShadowOpacity:0.3];
//            [v.layer setShadowOffset:CGSizeMake(1, 0)];
//            [v.layer setShadowRadius:0.5];
//            [v.layer setShouldRasterize:YES];
            [titleView addSubview:v];
        }
        
        offsetX += width;
    }
    
    // 添加表格
    rect = CGRectMake(0, headerHeight, self.bounds.size.width, self.bounds.size.height - headerHeight);
    UITableView *table = [[[UITableView alloc] initWithFrame:rect] autorelease];
//    [SKUtil borderWithView:table color:[UIColor clearColor] masksToBounds:YES];
    [table setDataSource:self];
    [table setDelegate:self];
    [table setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [table setSeparatorColor:[UIColor grayColor]];
    [_scrollView addSubview:table];
    
    if (offsetX > self.bounds.size.width) {
        
        CGRect r = titleView.frame;
        r.size.width = offsetX;
        [titleView setFrame:r];
        [imageView setFrame:r];
        [imageView setBackgroundColor:[UIColor colorWithPatternImage:_headerBgImage]];
        
        r = table.frame;
        r.size.width = offsetX;
        [table setFrame:r];
        
        [_scrollView setContentSize:CGSizeMake(offsetX, self.bounds.size.height)];
    }
}

- (void)_addViewToCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CGRect rect;
    UIView *v;
    UIButton *b;
    
    for (UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    CGFloat offsetX = 0;
    for (int i = 0; i < _numberOfColumns; i++) {
        CGFloat width = [[_columnWidthArray objectAtIndex:i] floatValue];
        if (i != _numberOfColumns - 1) {
            rect = CGRectMake(ceilf(offsetX), 0, width - 2, 40);
        } else {
            rect = CGRectMake(ceilf(offsetX), 0, width, 40);
        }
        b = [[[UIButton alloc] initWithFrame:rect] autorelease];
        if (indexPath.row % 2 == 0) {
            
        } else {
            [b setBackgroundColor:[UIColor colorWithRed:224 / 255.0 green:229 / 255.0 blue:233 / 255.0 alpha:1]];
        }
        [b setUserInteractionEnabled:NO];
        [b setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        NSString *title = [NSString stringWithFormat:@"(%d, %d)", indexPath.row, i];
        [b setTitle:title forState:(UIControlStateNormal)];
        [b.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:b];
        
        // 垂直分割线
        rect = CGRectMake(ceilf(offsetX - 2), 0, 1, rect.size.height);
        v = [[[UIView alloc] initWithFrame:rect] autorelease];
        [v setBackgroundColor:[UIColor grayColor]];
        [v.layer setShouldRasterize:YES];
        [v.layer setShadowColor:[UIColor whiteColor].CGColor];
        [v.layer setShadowOpacity:1];
        [v.layer setShadowOffset:CGSizeMake(1, 0)];
        [v.layer setShadowRadius:0];
        [cell.contentView addSubview:v];
        
        if (indexPath.row != 0) {
            // 水平分割线
            rect = CGRectMake(ceilf(offsetX - 1), 0, width, 1);
            v = [[[UIView alloc] initWithFrame:rect] autorelease];
            [v setBackgroundColor:[UIColor grayColor]];
            [v.layer setShouldRasterize:YES];
            [v.layer setShadowColor:[UIColor whiteColor].CGColor];
            [v.layer setShadowOpacity:1];
            [v.layer setShadowOffset:CGSizeMake(0, 1)];
            [v.layer setShadowRadius:0];
            [cell.contentView addSubview:v];
        }
        
        offsetX += width;
    }
}

@end
