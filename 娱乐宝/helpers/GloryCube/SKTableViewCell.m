//
//  SKTableViewCell.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKTableViewCell.h"

@interface SKTableViewCell ()

@property (nonatomic, retain) NSMutableArray *buttonArray;

@end

@implementation SKTableViewCell

- (void)dealloc {
    [_columnWidthArray release];
    [_titleArray release];
    [_buttonArray release];
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
//    SKLog(@"self.contentView.subviews.count: %d", self.contentView.subviews.count);
    if (self.contentView.subviews.count <= 1) {
        [self _initView];
    }
}

- (void)_initView {
    CGRect rect;
    UIView *v;
    UIButton *b;
    
    self.buttonArray = [NSMutableArray arrayWithCapacity:0];
    
    CGFloat offsetX = 0;
    for (int i = 0; i < [_columnWidthArray count]; i++) {
        CGFloat width = [[_columnWidthArray objectAtIndex:i] floatValue];
        if (i != [_columnWidthArray count] - 1) {
            rect = CGRectMake((offsetX), 0, width, self.contentView.bounds.size.height);
        } else {
            rect = CGRectMake((offsetX), 0, width, self.contentView.bounds.size.height);
        }
        b = [[[UIButton alloc] initWithFrame:rect] autorelease];
//        if (_indexPath.row % 2 == 0) {
//            
//        } else {
//            [b setBackgroundColor:[UIColor colorWithRed:224 / 255.0 green:229 / 255.0 blue:233 / 255.0 alpha:1]];
//        }
        [b setUserInteractionEnabled:YES];
        [b setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [b setBackgroundImage:[UIImage imageNamed:@"sk_table_cell_bg_1"] forState:(UIControlStateNormal)];
        if ([_titleArray count] == [_columnWidthArray count]) {
            [b setTitle:[_titleArray objectAtIndex:i] forState:(UIControlStateNormal)];
        }
        [b.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [b setTag:i];
        [b.titleLabel setLineBreakMode:(NSLineBreakByWordWrapping)];
        [b addTarget:self action:@selector(_actionForClickButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:b];
        [_buttonArray addObject:b];
        
        // 垂直分割线
        rect = CGRectMake((offsetX), 0, 1, rect.size.height);
        v = [[[UIView alloc] initWithFrame:rect] autorelease];
        [v setBackgroundColor:[UIColor grayColor]];
//        [v.layer setShouldRasterize:YES];
//        [v.layer setShadowColor:[UIColor whiteColor].CGColor];
//        [v.layer setShadowOpacity:1];
//        [v.layer setShadowOffset:CGSizeMake(1, 0)];
//        [v.layer setShadowRadius:0];
        [self.contentView addSubview:v];
        
        if (i == [_columnWidthArray count] - 1) {
            rect = CGRectMake((offsetX) + width - 1, 0, 1, rect.size.height);
            v = [[[UIView alloc] initWithFrame:rect] autorelease];
            [v setBackgroundColor:[UIColor darkGrayColor]];
            [self.contentView addSubview:v];
        }
        
        // 水平分割线
        rect = CGRectMake((offsetX), rect.size.height - 1, width, 1);
        v = [[[UIView alloc] initWithFrame:rect] autorelease];
        [v setBackgroundColor:[UIColor grayColor]];
//        [v.layer setShouldRasterize:YES];
//        [v.layer setShadowColor:[UIColor whiteColor].CGColor];
//        [v.layer setShadowOpacity:1];
//        [v.layer setShadowOffset:CGSizeMake(1, 0)];
//        [v.layer setShadowRadius:0];
        [self.contentView addSubview:v];
        
//        if (_indexPath.row != 0) {
            // 水平分割线
//            rect = CGRectMake(ceilf(offsetX - 1), 0, width, 1);
//            v = [[[UIView alloc] initWithFrame:rect] autorelease];
//            [v setBackgroundColor:[UIColor grayColor]];
//            [v.layer setShouldRasterize:YES];
//            [v.layer setShadowColor:[UIColor whiteColor].CGColor];
//            [v.layer setShadowOpacity:1];
//            [v.layer setShadowOffset:CGSizeMake(0, 1)];
//            [v.layer setShadowRadius:0];
//            [self.contentView addSubview:v];
//        }
    
        offsetX += width;
    }
}

- (void)setTitleArray:(NSMutableArray *)titleArray {
    if (_titleArray != titleArray) {
        [_titleArray release];
        _titleArray = [titleArray retain];
        
        if ([_buttonArray count] == [_titleArray count]) {
            for (int i = 0; i < [_buttonArray count]; i++) {
                [[_buttonArray objectAtIndex:i] setTitle:[_titleArray objectAtIndex:i] forState:(UIControlStateNormal)];
            }
        }
    }
}

- (void)_actionForClickButton:(UIButton *)button {
//    SKLog(@"self.tag: %d; button.tag: %d", self.tag, button.tag);
    if ([_delegate respondsToSelector:@selector(tableViewCell:didClickAtRowIndex:columnIndex:)]) {
        [_delegate tableViewCell:self didClickAtRowIndex:self.tag columnIndex:button.tag];
    }
}

@end
