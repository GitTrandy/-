//
//  SKMulticolumnTableViewCell.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKMulticolumnTableViewCell : UITableViewCell

@property (nonatomic, retain) NSMutableArray *cellOfColumnArray;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier widthOfColumnArray:(NSArray *)widthOfColumnArray;

@end
