//
//  SKMulticolumnTableView.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKMulticolumnTableView.h"
#import "SKMulticolumnTableViewCell.h"

@interface SKMulticolumnTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) CGFloat heightOfHeader;
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) NSInteger numberOfRows;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *widthOfColumnArray;

@end

@implementation SKMulticolumnTableView
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_headerView release];
    [_table release];
    [_widthOfColumnArray release];
    
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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self _initData];
    }
    return self;
}

- (void)layoutSubviews {
    if ([self.subviews count] == 0) {
        [self _initView];
    }
}

- (void)setFrame:(CGRect)frame {
    CGRect lastFrame = self.frame;
    [super setFrame:frame];
    
    CGFloat deltaHeight = frame.size.height - lastFrame.size.height;
    CGRect tableFrame = [_table frame];
    tableFrame.size.height = tableFrame.size.height + deltaHeight;
    [_table setFrame:tableFrame];
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
- (void)reloadData {
    [_table reloadData];
}

#pragma mark -
#pragma mark Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_datasource numberOfRowsInMulticolumnTableView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    SKMulticolumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[SKMulticolumnTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier widthOfColumnArray:_widthOfColumnArray] autorelease];
    }
    [cell setSelectionStyle:_selectionStyle];
    
    if ([_delegate respondsToSelector:@selector(multicolumnTable:didInitCellViewAtIndexPath:tableViewCell:)]) {
        [_delegate multicolumnTable:self didInitCellViewAtIndexPath:indexPath tableViewCell:cell];
    }
    
    NSMutableArray *cellViewArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < _numberOfColumns; i++) {
        UIView *lastCellView = nil;
        if (cell.cellOfColumnArray != nil && cell.cellOfColumnArray.count > 0) {
            lastCellView = [cell.cellOfColumnArray objectAtIndex:i];
        }
        UIView *cellView = [_datasource multicolumnTable:self viewForRowIndex:indexPath.row columnIndex:i];
        
        // cell.cellOfColumnArray != nil 表示重用了cell
        if (cell.cellOfColumnArray != nil) {
            [lastCellView removeFromSuperview];
            [cellView setFrame:lastCellView.frame];
            [cell.contentView addSubview:cellView];
        }
        
        [cellViewArray addObject:cellView];
    }
    [cell setCellOfColumnArray:cellViewArray];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44;
    if ([_datasource respondsToSelector:@selector(multicolumnTable:heightForRowIndex:)]) {
        height = [_datasource multicolumnTable:self heightForRowIndex:indexPath.row];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(multicolumnTable:didSelectRowAtIndexPath:tableView:)]) {
        [_delegate multicolumnTable:self didSelectRowAtIndexPath:indexPath tableView:tableView];
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return _headerView;
//}
#pragma mark UIScrollView Code
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(multicolumnTableDidScroll:)]) {
        [_delegate multicolumnTableDidScroll:self];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(multicolumnTableWillBeginDragging:)]) {
        [_delegate multicolumnTableWillBeginDragging:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(multicolumnTableDidEndDecelerating:)]) {
        [_delegate multicolumnTableDidEndDecelerating:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(multicolumnTableDidEndScrollingAnimation:)]) {
        [_delegate multicolumnTableDidEndScrollingAnimation:self];
    }
}

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// TODO: init data code
    self.heightOfHeader = 44;
    self.widthOfColumnArray = [NSMutableArray arrayWithCapacity:0];
    self.table = [[[UITableView alloc] initWithFrame:CGRectZero] autorelease];
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    [_table setDataSource:self];
    [_table setDelegate:self];
}

- (void)_initView {
	// TODO: init view code
    if ([_datasource respondsToSelector:@selector(heightForHeaderViewInMulticolumnTable:)]) {
        self.heightOfHeader = [_datasource heightForHeaderViewInMulticolumnTable:self];
    }
    
    [_headerView removeFromSuperview];
    self.headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _heightOfHeader)] autorelease];
    
    [self addSubview:_headerView];
    
    self.numberOfColumns = [_datasource numberOfColumnsInMulticolumnTableView:self];
//    self.numberOfRows = [_datasource numberOfRowsInMulticolumnTableView:self]; // 如果只在这里调用一次，就没法响应reloadData方法，因为数据源的个数在这里被定死了
    
    CGFloat offsetX = 0;
    for (int i = 0; i < _numberOfColumns; i++) {
        CGFloat width = [_datasource multicolumnTable:self widthForColumnIndex:i];
        [_widthOfColumnArray addObject:[NSNumber numberWithFloat:width]];
        UIView *headerCell = [_datasource multicolumnTable:self ViewForHeaderAtColumnIndex:i];
        [headerCell setFrame:CGRectMake(floorf(offsetX), 0, width, _heightOfHeader)];
        [_headerView addSubview:headerCell];
        
        offsetX += width;
    }
    
    [_table setFrame:CGRectMake(0, _heightOfHeader, self.bounds.size.width, self.bounds.size.height - _heightOfHeader)];
    [_table setSeparatorStyle:_separatorStyle];
    [self addSubview:_table];
}

@end
