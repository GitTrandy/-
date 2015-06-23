//
//  MoreViewController.m
//  推送测试
//
//  Created by Zhang_JK on 15/3/28.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "MoreViewController.h"
#import "QuartViewController.h"
#import "PdfViewController.h"
typedef enum DRAWTYPE
{
    QUART_2D=0,
    PDFSHOW
    
}DRAWTYPE;


@interface MoreViewController ()
<UITableViewDelegate
,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)QuartViewController *quartCtr;
@property (nonatomic,strong)PdfViewController *pdfCtr;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [_dataArray addObject:@"Quart 2D"];
    [_dataArray addObject:@"PDF SHOW"];
    [_tableView reloadData];
    

}
#pragma mark _tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *identifier = @"iCell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
    }
    NSString *title = _dataArray[indexPath.row];
    
    cell.textLabel.text = title;
    return cell;
}

#pragma mark _tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    switch (index) {
        case QUART_2D:
            [self  transtoQUART];
            break;
        case PDFSHOW:
            [self  transtoPDFSHOW];
            break;
 
        default:
            break;
    }

}

- (void)transtoPDFSHOW
{
    _pdfCtr = [[PdfViewController alloc] init];
    [self.navigationController pushViewController:_pdfCtr animated:YES];
    
}
#pragma mark QUART 2D
- (void)transtoQUART
{

    _quartCtr = [[QuartViewController alloc] init];
    [self.navigationController pushViewController:_quartCtr animated:YES];
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
