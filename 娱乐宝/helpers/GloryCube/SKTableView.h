//
//  SKTableView.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTableView;

@protocol SKTableViewDelegate <NSObject>

@required
- (NSInteger)numberOfColumnsInTableView:(SKTableView *)tableView;
- (CGFloat)tableView:(SKTableView *)tableView widthForColumnIndex:(NSInteger)index;
- (NSString *)tableView:(SKTableView *)tableView titleForColumnIndex:(NSInteger)index;
- (NSArray *)tableView:(SKTableView *)tableView titlesForCellAtRowIndex:(NSInteger)index;
- (NSInteger)numberOfRowsInTableView:(SKTableView *)tableView;

@optional
- (CGFloat)heightForHeaderInTableView:(SKTableView *)tableView;
- (void)tableView:(SKTableView *)tableView didClickAtRowIndex:(NSInteger)rowIndex columnIndex:(NSInteger)columnIndex;
- (CGFloat)tableView:(SKTableView *)tableView heightForRowIndex:(NSInteger)rowIndex;

@end

@interface SKTableView : UIView

@property (nonatomic, assign) IBOutlet id<SKTableViewDelegate> delegate;
@property (nonatomic, assign, readonly) NSInteger numberOfColumns;
@property (nonatomic, retain) UIImage *headerBgImage;
@property (nonatomic, assign) BOOL clickable;

@end
