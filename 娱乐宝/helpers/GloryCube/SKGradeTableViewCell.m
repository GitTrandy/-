//
//  SKGradeTableViewCell.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKGradeTableViewCell.h"
#import "SKLog.h"

@interface SKGradeTableViewCell ()

@property (nonatomic, retain) UIButton *textButton;
@property (nonatomic, copy) NSString *highlightImageName;
@property (nonatomic, retain) UIView *line;
@property (nonatomic, assign) SKGradeTableView *gradeTable;

@end

@implementation SKGradeTableViewCell

- (void)dealloc {
    [_textButton release];
    [_highlightImageName release];
    [_line release];
    
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
    [self _initView];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier highlightImageName:(NSString *)imageName gradeTable:(SKGradeTableView *)gradeTable
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.highlightImageName = imageName;
        self.gradeTable = gradeTable;
        [self _initData];
    }
    return self;
}

- (void)_initData {
    self.textButton = [[[UIButton alloc] initWithFrame:self.contentView.bounds] autorelease];
    [_textButton setBackgroundImage:[UIImage imageNamed:_highlightImageName] forState:(UIControlStateHighlighted)];
    [_textButton setBackgroundColor:[UIColor whiteColor]];
    [_textButton addTarget:_gradeTable action:@selector(_actionForClickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [_textButton setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    [_textButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_textButton.titleLabel setLineBreakMode:(NSLineBreakByWordWrapping)];
    [self.contentView addSubview:_textButton];
    
    self.line = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [_line setBackgroundColor:[UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1]];
}

- (void)_initView {
    [_textButton setFrame:self.contentView.bounds];
    
    if (self.tag != 0) {
        [_line setFrame:CGRectMake(0, 0, 1, self.contentView.bounds.size.height)];
        [self.contentView addSubview:_line];
    }
}

- (void)_actionForClickButton:(UIButton *)button {
//    SKLog(@"");
}

@end
