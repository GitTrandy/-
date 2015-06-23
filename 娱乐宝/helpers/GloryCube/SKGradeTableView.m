//
//  SKGradeTableView.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKGradeTableView.h"
#import "SKGradeTableViewCell.h"

@interface SKGradeTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic, assign) NSInteger numberOfColumns;

@end

@implementation SKGradeTableView
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_tableArray release];
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    for (UITableView *tb in _tableArray) {
        if (tb != scrollView) {
            [tb setContentOffset:offset];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource gradeTable:self numberOfRowsForColumnIndex:tableView.tag];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SKGradeTableViewCell *cell = [_dataSource gradeTable:self cellForRowIndex:indexPath.row columnIndex:tableView.tag tableView:tableView];
    
    [cell.textButton setTag:indexPath.row]; // 行索引
    [cell.textButton.superview setTag:tableView.tag]; // 列索引
    [cell setTag:tableView.tag];
    
    return cell;
    
//    static NSString *identifier = @"Cell";
//    SKGradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[[SKGradeTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier highlightImageName:@"titlebg"] autorelease];
//    }
//    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
//    
//    [cell.textButton setTitle:[NSString stringWithFormat:@"%@", indexPath] forState:(UIControlStateNormal)];
//    
//    UIColor *bgColor = [UIColor whiteColor];
//    if (tableView.tag == 0) {
//        bgColor = (((indexPath.row % 2) == 0) ?
//                   [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1]:
//                   [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1]);
//    } else {
//        bgColor = (((indexPath.row % 2) == 0) ?
//                   [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1]:
//                   [UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:1]);
//    }
//    
//    [cell.textButton setBackgroundColor:bgColor];
//    
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_dataSource gradeTable:self heightForRowIndex:indexPath.row columnIndex:tableView.tag];
}

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// TODO: init data code
    self.tableArray = [NSMutableArray arrayWithCapacity:0];
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)_initView {
	// TODO: init view code
    [self setBackgroundColor:[UIColor redColor]];
    
    self.numberOfColumns = [_dataSource numberOfColumnsInGradeTable:self];
    CGFloat offsetX = 0;
    for (int i = 0; i < _numberOfColumns; i++) {
        CGFloat width = [_dataSource gradeTable:self widthForColumnIndex:i];
        UITableView *table = [[[UITableView alloc] initWithFrame:CGRectMake(floorf(offsetX), 0, width, self.bounds.size.height)] autorelease];
        [table setDataSource:self];
        [table setDelegate:self];
        [table setShowsHorizontalScrollIndicator:NO];
        [table setShowsVerticalScrollIndicator:NO];
        [table setSeparatorStyle:_separatorStyle];
        [table setTag:i];
        [self addSubview:table];
        [_tableArray addObject:table];
        
        offsetX += width;
    }
}

- (void)_actionForClickButton:(UIButton *)button {
//    SKLog(@"");
    if ([_delegate respondsToSelector:@selector(gradeTable:didClickAtButton:rowIndex:cloumnIndex:)]) {
        [_delegate gradeTable:self didClickAtButton:button rowIndex:button.tag cloumnIndex:button.superview.tag];
    }
}

@end
