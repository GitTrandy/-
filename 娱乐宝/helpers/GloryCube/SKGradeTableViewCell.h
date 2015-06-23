//
//  SKGradeTableViewCell.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKGradeTableView;

@interface SKGradeTableViewCell : UITableViewCell

@property (nonatomic, retain, readonly) UIButton *textButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier highlightImageName:(NSString *)imageName gradeTable:(SKGradeTableView *)gradeTable;

@end
