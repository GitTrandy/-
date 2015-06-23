//
//  SearchViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/6/2.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{
    NSMutableArray *_dataArray;
    NSMutableArray *custList;

}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    custList = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray *arr  = [[NSArray alloc] initWithObjects:
                      @"德州银行滨州彩虹湖小微支行",
                      @"德州银行陵县新市街支行",
                      @"德州银行临邑县洛源小微支行",
                      @"德州银行夏津县锦纺小微支行",
                      @"德州银行武城振华西小微支行",
                      @"德州银行陵县世纪小微支行",
                      @"德州银行乐陵五洲小微支行",
                      @"德州银行禹城洛北小微支行",
                      @"德州银行滨州胜滨小微支行",
                      @"德州银行滨州分行博兴支行",
                      @"德州银行夏津南城街支行",
                      @"德州银行股份有限公司烟台分行",
                      @"德州银行股份有限公司平原龙门支行",
                      @"德州银行股份有限公司庆云北海社区支行",
                      @"德州银行股份有限公司临邑南鑫社区支行",
                      @"德州银行股份有限公司齐河晏东社区支行",
                      @"德州银行股份有限公司乾城社区支行",
                      @"德州银行股份有限公司天域社区支行",
                      @"德州银行乐陵兴隆支行营业部",
                      @"德州银行滨州分行",
                      @"德州银行武城鲁权屯支行营业部",
                      @"德州银行夏津支行营业部",
                      @"德州银行陵县支行营业部",
                      @"德州银行乐陵支行营业部",
                      @"德州银行武城支行营业部",
                      @"德州银行平原支行营业部",
                      @"德州银行禹城行政街支行营业部",
                      @"德州银行禹城支行营业部",
                      @"德州银行临邑临盘支行营业部",
                      @"德州银行临邑支行营业部",
                      @"德州银行齐河南龙支行营业部",
                      @"德州银行齐河支行营业部",
                      @"德州银行宁津正阳路支行营业部",
                      @"德州银行宁津支行营业部",
                      @"德州银行西城支行营业部",
                      @"德州银行康乐支行营业部",
                      @"德州银行天衢中路支行营业部",
                      @"德州银行天衢东路支行营业部",
                      @"德州银行车站支行营业部",
                      @"德州银行鑫都支行营业部",
                      @"德州银行东方红支行营业部",
                      @"德州银行银河支行营业部",
                      @"德州银行新生支行营业部",
                      @"德州银行新华支行营业部",
                      @"德州银行金诚支行营业部",
                      @"德州银行三八路支行营业部",
                      @"德州银行湖滨支行营业部",
                      @"德州银行科技园支行营业部",
                      @"德州银行和鑫支行营业部",
                      @"德州银行环城支行营业部",
                      @"德州银行开发区支行营业部",
                      @"德州银行惠德支行营业部",
                      @"德州银行东风路支行营业部",
                      @"德州银行北园支行营业部",
                      @"德州银行向阳支行营业部",
                      @"德州银行解放路支行营业部",
                      @"德州银行营业部",
                      @"德州银行德兴支行营业部",
                      @"德州银行股份有限公司政务中心小微支行",
                      @"德州银行金融市场部营业部",
                      @"德州银行银行卡管辖中心营业部",
                      @"德州银行国际业务部",
                      @"德州银行第六客户服务中心",
                      @"德州银行第五客户服务中心（原）",
                      @"德州银行第三管辖行",
                      @"德州银行第三客户服务中心（原）",
                      @"德州银行第二管辖行",
                      @"德州银行第一管辖行",
                      @"德州银行总行",
                      @"德州银行股份有限公司清算中心",
                      @"德州银行庆云支行营业部", nil];
    NSMutableArray *simpNames = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *pinyins = [[NSMutableArray alloc] init];
    
    for (NSString *str in arr) {
        NSString *str2 = [str substringFromIndex:4];
        [simpNames addObject:str2];
    
        NSLog(@"str2 is %@",str2);
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:str2,@"name", nil];
        [custList addObject:dic];
        
    }
    
    _dataArray = [[NSMutableArray alloc]initWithArray:custList];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identityCell =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identityCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identityCell];
    }
    cell.textLabel.text = [_dataArray[indexPath.row] objectForKey:@"name"];
    return cell;

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchText is %@",searchText);
    if ([searchText isEqualToString:@""]) {
        _dataArray = custList;
        NSLog(@"custList is %@",custList);
        [_myTabBar reloadData];
        return;
    }
    NSString *keyName = @"name";
    /**< 模糊查找*/
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K contains[cd] %@", keyName, searchText];
    /**< 精确查找*/
    //  NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K == %@", keyName, searchText];
    NSLog(@"predicateString %@",predicateString);
    NSMutableArray  *filteredArray = [NSMutableArray arrayWithArray:[custList filteredArrayUsingPredicate:predicateString]];
    _dataArray = filteredArray;
    [_myTabBar reloadData];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_mySearch resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
