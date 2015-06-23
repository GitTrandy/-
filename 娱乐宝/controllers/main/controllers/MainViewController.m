//
//  MainViewController.m
//  推送测试
//
//  Created by Zhang_JK on 15/3/28.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "MainViewController.h"
#import "MovesDetailController.h"
#import "MusicDetailController.h"
#import "NovesDetailController.h"
#import "PlistViewController.h"
#import "IDCardViewController.h"
#import "ProgressViewController.h"
#import "SearchViewController.h"
#import "DuoXianChengController.h"
@interface MainViewController ()

@end

@implementation MainViewController
{
    NSMutableArray *_dataArray;
}
- (void)initData
{
    _dataArray = [[NSMutableArray alloc] initWithObjects:
                  @"plistFilemanager",
                  @"IDcardCheck",
                  @"ProgressView",
                  @"Search",
                  @"movesDetailAction",
                  @"多线程",nil];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view from its nib.

    //获取本地桌面
    NSString *path = @"Users/k721684713/Desktop/学习资料";
    NSString *plistPath =[path stringByAppendingPathComponent:@"pdcList.plist"];
    NSLog(@"plistPath is %@",plistPath);
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithArray:[[NSDictionary dictionaryWithContentsOfFile:plistPath]objectForKey:@"pdcList"]];
    NSLog(@"pdcList is %@",tmpArr);
    
    //存储到plist文件中
    NSArray *arr = [[NSArray alloc]initWithObjects:@"a",@"e",@"f",@"b",@"c", nil];
    NSMutableArray *mA = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *str in arr) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject: str forKey:@"ordNum"];
        [mA addObject:dict];
    }
    NSMutableArray *tmp = [self arraySort:mA];
    NSLog(@"tmo is %@",tmp);
    
    
}
- (NSMutableArray *)arraySort:(NSArray *)waitArr{
    NSSortDescriptor *SD =
    [[NSSortDescriptor alloc] initWithKey:@"ordNum" ascending:YES];
    NSArray *lobbyList = [waitArr sortedArrayUsingDescriptors:
                          [NSArray arrayWithObjects:SD,nil]];
    
    return [[NSMutableArray alloc] initWithArray:lobbyList] ;
}

#pragma mark -tabDataSource
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identy  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identy];
        
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.row;
    switch (index) {
        case 0:
            [self plistFilemanager:nil];
            break;
        case 1:
            [self jump2IDCardController:nil];
            break;
            
        case 2:
            [self jump2Download :nil];
            break;
            
        case 3:
            [self jump2Search:nil];
            break;
            
        case 4:
            [self movesDetailAction:nil];
            break;
            
        case 5:
            [self jump2Duoxiancheng];
            break;


        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)movesDetailAction:(UIButton *)sender {
    MovesDetailController *moves = [[MovesDetailController alloc] init];
    //[self presentViewController:moves animated:YES completion:nil];
    [self.navigationController pushViewController:moves animated:YES];
    
}
- (IBAction)musicDetailAction:(UIButton *)sender {
    MusicDetailController *music = [[MusicDetailController alloc] init];

    [self.navigationController pushViewController:music animated:YES];
    
}
- (IBAction)newsDeitailAction:(UIButton *)sender {
//    NewsDetailController *news = [[NewsDetailController alloc] init];
//    [self.navigationController pushViewController:news animated:YES];
}
- (IBAction)noveiDetialAction:(UIButton *)sender {
    NovesDetailController *novel= [[NovesDetailController alloc] init];
    [self.navigationController pushViewController:novel animated:YES];
    
}
- (IBAction)plistFilemanager:(UIButton *)sender {
    PlistViewController *pCtr = [[PlistViewController alloc] init];
    [self.navigationController pushViewController:pCtr animated:YES];
    
}
- (IBAction)jump2IDCardController:(id)sender {
    IDCardViewController *cardCtr = [[IDCardViewController alloc] init];
    [self.navigationController pushViewController:cardCtr animated:YES];
    
}
- (IBAction)jump2Download:(id)sender {
    ProgressViewController *pvc = [[ProgressViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
    
}
- (IBAction)jump2Search:(id)sender {
    SearchViewController *sCtr = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:sCtr animated:YES];
    
}
- (void)jump2Duoxiancheng {
    DuoXianChengController *dCtr = [[DuoXianChengController alloc] init];
    [self.navigationController pushViewController:dCtr animated:YES];
    
}
@end
