//
//  MovesDetailController.m
//  推送测试
//
//  Created by Zhang_JK on 15/3/28.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#define URLSTR @""

#import "MovesDetailController.h"
#import "WebMovesController.h"

@interface MovesDetailController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@end

@implementation MovesDetailController
{
    NSMutableArray *_dataArray;

    __weak IBOutlet UITableView *_tabView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *pps = @"http://www.pps.tv";
    NSString *iqiyi = @" http://www.iqiyi.com";
    NSString *youku = @"http://www.youku.com";
    NSString *baofeng = @"http://www.baofeng.com";
    NSString *iseedy = @"http://www.iseedy.com";
    NSString *qq = @"http://v.hao.qq.com";
    _dataArray = [[NSMutableArray alloc] initWithObjects:pps,iqiyi,youku,baofeng,iseedy,qq, nil];
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *idtifiCell = [NSString stringWithFormat:@"%@",@"cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idtifiCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idtifiCell];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *urlStr = [_dataArray objectAtIndex:indexPath.row];
    WebMovesController *mvc = [[WebMovesController alloc] init];
    mvc.webURL = urlStr;
    [self.navigationController pushViewController:mvc animated:YES];
    
    
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
