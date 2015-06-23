//
//  SKTableViewCell.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTableViewCell;

@protocol SKTableViewCellDelegate <NSObject>

@optional
- (void)tableViewCell:(SKTableViewCell *)cell didClickAtRowIndex:(NSInteger)rowIndex columnIndex:(NSInteger)columnIndex;

@end

@interface SKTableViewCell : UITableViewCell

@property (nonatomic, assign) id<SKTableViewCellDelegate> delegate;
@property (nonatomic, retain) NSArray *columnWidthArray;
@property (nonatomic, retain) NSArray *titleArray;

@end
