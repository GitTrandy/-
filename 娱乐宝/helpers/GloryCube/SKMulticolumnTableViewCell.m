//
//  SKMulticolumnTableViewCell.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKMulticolumnTableViewCell.h"

@interface SKMulticolumnTableViewCell ()

@property (nonatomic, retain) NSArray *widthOfColumnArray;

@end

@implementation SKMulticolumnTableViewCell

- (void)dealloc {

    [_cellOfColumnArray release];
    [_widthOfColumnArray release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.subviews.count <= 1) {
        [self _initView];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier widthOfColumnArray:(NSArray *)widthOfColumnArray {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.widthOfColumnArray = widthOfColumnArray;
    }
    return self;
}

- (void)_initView {
    CGFloat offsetX = 0;
    for (int i = 0; i < [_cellOfColumnArray count]; i++) {
        CGFloat width = [[_widthOfColumnArray objectAtIndex:i] floatValue];
        CGRect rect = CGRectMake(floorf(offsetX), 0, width, self.contentView.bounds.size.height);
        UIView *cellView = [_cellOfColumnArray objectAtIndex:i];
        [cellView setFrame:rect];
        [self.contentView addSubview:cellView];
        
        offsetX += width;
    }
}

@end
