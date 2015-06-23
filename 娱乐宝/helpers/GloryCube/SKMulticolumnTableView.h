//
//  SKMulticolumnTableView.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKMulticolumnTableView;

@protocol SKMulticolumnTableViewDataSource <NSObject>

@required
- (NSInteger)numberOfColumnsInMulticolumnTableView:(SKMulticolumnTableView *)multicolumnTable;
- (NSInteger)numberOfRowsInMulticolumnTableView:(SKMulticolumnTableView *)multicolumnTable;
- (UIView *)multicolumnTable:(SKMulticolumnTableView *)multicolumnTable ViewForHeaderAtColumnIndex:(NSInteger)columnIndex;
- (CGFloat)multicolumnTable:(SKMulticolumnTableView *)multicolumnTable widthForColumnIndex:(NSInteger)columnIndex;
- (UIView *)multicolumnTable:(SKMulticolumnTableView *)multicolumnTable viewForRowIndex:(NSInteger)rowIndex columnIndex:(NSInteger)columnIndex;

@optional
- (CGFloat)heightForHeaderViewInMulticolumnTable:(SKMulticolumnTableView *)multicolumnTable;
- (CGFloat)multicolumnTable:(SKMulticolumnTableView *)multicolumnTable heightForRowIndex:(NSInteger)rowIndex;

@end

@protocol SKMulticolumnTableViewDelegate <NSObject>

@optional
- (void)multicolumnTable:(SKMulticolumnTableView *)multicolumnTable didInitCellViewAtIndexPath:(NSIndexPath *)indexPath tableViewCell:(UITableViewCell *)tableViewCell;
- (void)multicolumnTable:(SKMulticolumnTableView *)multicolumnTable didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
- (void)multicolumnTableDidScroll:(SKMulticolumnTableView *)multicolumnTable;
- (void)multicolumnTableWillBeginDragging:(SKMulticolumnTableView *)multicolumnTable;
- (void)multicolumnTableDidEndDecelerating:(SKMulticolumnTableView *)multicolumnTable;
- (void)multicolumnTableDidEndScrollingAnimation:(SKMulticolumnTableView *)multicolumnTable;

@optional

@end

@interface SKMulticolumnTableView : UIView

@property (nonatomic, assign) IBOutlet id<SKMulticolumnTableViewDataSource> datasource;
@property (nonatomic, assign) IBOutlet id<SKMulticolumnTableViewDelegate> delegate;
@property (nonatomic, assign) UITableViewCellSeparatorStyle separatorStyle;
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic, retain, readonly) UITableView *table;

- (void)reloadData;

@end
