//
//  SKGradeTableView.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKGradeTableView;
@class SKGradeTableViewCell;

@protocol SKGradeTableViewDataSource <NSObject>

@required
- (NSInteger)numberOfColumnsInGradeTable:(SKGradeTableView *)gradeTable;
- (CGFloat)gradeTable:(SKGradeTableView *)gradeTable widthForColumnIndex:(NSInteger)index;
- (NSInteger)gradeTable:(SKGradeTableView *)gradeTable numberOfRowsForColumnIndex:(NSInteger)index;
- (CGFloat)gradeTable:(SKGradeTableView *)gradeTable heightForRowIndex:(NSInteger)rowIndex columnIndex:(NSInteger)columnIndex;
- (SKGradeTableViewCell *)gradeTable:(SKGradeTableView *)gradeTable cellForRowIndex:(NSInteger)rowIndex columnIndex:(NSInteger)columnIndex tableView:(UITableView *)tableView;

@end

@protocol SKGradeTableViewDelegate <NSObject>

@optional
- (void)gradeTable:(SKGradeTableView *)gradeTable didClickAtButton:(UIButton *)button rowIndex:(NSInteger)rowIndex cloumnIndex:(NSInteger)columnIndex;

@end

@interface SKGradeTableView : UIView

@property (nonatomic, assign) IBOutlet id<SKGradeTableViewDataSource> dataSource;
@property (nonatomic, assign) IBOutlet id<SKGradeTableViewDelegate> delegate;
@property (nonatomic, assign) UITableViewCellSeparatorStyle separatorStyle;

@end
