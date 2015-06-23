//
//  SearchViewController.h
//  娱乐宝
//
//  Created by Zhang_JK on 15/6/2.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
<UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *mySearch;
@property (weak, nonatomic) IBOutlet UITableView *myTabBar;


@end
