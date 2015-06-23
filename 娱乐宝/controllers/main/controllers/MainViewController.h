//
//  MainViewController.h
//  推送测试
//
//  Created by Zhang_JK on 15/3/28.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "RootViewController.h"

@interface MainViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *movesLab;
@property (weak, nonatomic) IBOutlet UILabel *musicLab;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;
@property (weak, nonatomic) IBOutlet UILabel *novesLab;
@property (weak, nonatomic) IBOutlet UIButton *movesDetail;
@property (weak, nonatomic) IBOutlet UIButton *musicDetail;
@property (weak, nonatomic) IBOutlet UIButton *newsDetail;
@property (weak, nonatomic) IBOutlet UIButton *novesDetail;
@property (weak, nonatomic) IBOutlet UITableView *mainTabView;

@end
