//
//  FamilyTurnViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/4/21.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "FamilyTurnViewController.h"
#import "CutToViewController.h"
@interface FamilyTurnViewController ()
<UITableViewDataSource,
UITableViewDelegate>
{
    NSArray *_dataArr;
    NSMutableArray *_subArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@property (nonatomic,strong)CutToViewController *ctCtr;
@end

@implementation FamilyTurnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArr = [[NSArray alloc] initWithObjects:@"fade",@"movein",@"push",@"reveal",
                        @"cube",@"oglFlip",@"suckEffect",@"rippleEffect",
                        @"pageCurl",@"pageUnCurl",@"cameralIrisHollowOpen",
                        @"cameraIrisHollowClose", nil];
    _subArr = [[NSMutableArray alloc] initWithObjects:
               @"淡出效果",
               @"新视图移动到旧视图上",
               @"新视图推出旧视图",
               @"移开旧视图显⽰示新视图",
               @"⽴立⽅方体翻转效果",
               @"翻转效果",@"收缩效果",
               @"⽔水滴波纹效果",
               @"向上翻⻚页效果",
               @"向下翻⻚页效果",
               @"摄像头打开效果",
               @"摄像头关闭效果",
               nil];
    
    _tabView.delegate = self;
    _tabView.dataSource = self;
    
}

#pragma mark tabViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"iCell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
    }
    NSString *title = _dataArr[indexPath.row];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text =_subArr [indexPath.row];
    
    return cell;

}
#pragma mark tabViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *catogory = _dataArr[indexPath.row];
    _ctCtr = [[CutToViewController alloc] init];
    _ctCtr.catogoryName =catogory;
    [self.navigationController pushViewController:_ctCtr animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
