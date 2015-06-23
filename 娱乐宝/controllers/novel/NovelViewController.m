//
//  NovelViewController.m
//  推送测试
//
//  Created by Zhang_JK on 15/3/28.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "NovelViewController.h"
#import "YSLayerViewController.h"
#import "DRCALayerViewController.h"
#import "CutomViewController.h"
#import "CoreAnimationViewController.h"
#import "AnimationValuesViewController.h"
#import "AnimationPathViewController.h"
#import "AnimationsArrViewController.h"
#import "CutToViewController.h"
#import "FamilyTurnViewController.h"
#import "CADisplayLinkViewController.h"
#import "UIViewAnimationViewController.h"

#define kWIDTH [[UIScreen mainScreen]bounds].size.width
#define KHEIGHT [[UIScreen mainScreen]bounds].size.height


typedef enum CATERGORY
{
    
    LAYER_SHOW=0,
    LAYER_DRAW,
    LAYER_CUSTOM,
    ANIMATION_CORE,
    ANIMATION_VALUES,
    ANIMATION_PATH,
    ANIMATION_ARR,
    ANIMATION_CUTTO,
    ANIMATION_CAD,
    ANIMATION_UIVIEW
    
    
}CATERGORY;



@interface NovelViewController ()
<UITableViewDataSource,
UITableViewDelegate
>
{
    NSMutableArray *_dataArray;
    NSMutableArray *_subArray;
    UITableView *_tableView;
}

@property (nonatomic, strong)DRCALayerViewController *DRCtr;
@property (nonatomic, strong)YSLayerViewController *YSCtr;
@property (nonatomic, strong)CutomViewController *CCtr;
@property (nonatomic, strong)CoreAnimationViewController *CACtr;
@property (nonatomic, strong)AnimationValuesViewController *VaCtr;
@property (nonatomic, strong)AnimationPathViewController *PaCtr;
@property (nonatomic, strong)AnimationsArrViewController *aniArrCtr;
@property (nonatomic, strong)CutToViewController *cutCtr;
@property (nonatomic, strong)FamilyTurnViewController *fCtr;
@property (nonatomic, strong)CADisplayLinkViewController *CADCtr;
@property (nonatomic, strong)UIViewAnimationViewController *UIVCtr;

- (IBAction)YSCALayer:(id)sender;
- (IBAction)CALayerDray:(id)sender;
- (IBAction)CutomDraw:(id)sender;
- (IBAction)coreAnimation:(id)sender;
- (IBAction)setAnimationAsValue:(id)sender;
- (IBAction)setAnimationAsPath:(id)sender;
- (void)animationArr;
- (void)animationCutTo;
- (void)animationCADLink;
- (void)uiViewAnimation;
@end


@implementation NovelViewController

#pragma mark -initData
- (void)initData{
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"CALayer",@"CALayerDraw",@"coreAnimation",@"CABasicAnimation",@"CAKeyframeAnimation Value",@"CAKeyframeAnimation Path",@"CAAnimationGroup",@"CATransition", @"CADisplayLink",@"UIView",nil];
    
    _subArray = [[NSMutableArray alloc] initWithObjects:
                  @"图层属性演示",
                  @"CALayer绘图",
                  @"自定义绘图",
                  @"Core Animation",
                  @"Value设置关键帧动画",
                  @"Path设置关键帧动画",
                  @"动画组",
                  @"转场动画",
                  @"逐帧动画",
                  @"UIView动画封装",
                  nil];
    

}

#pragma mark - initTabView code

- (void)initTabView{

//    CGRect rect = CGRectMake(0, 0,kWIDTH, KHEIGHT);
//    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
//    [self.view addSubview:_tableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initTabView];

  }

#pragma mark -_tableViewDelegate Code

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger index = indexPath.row;
    switch (index) {
        case LAYER_SHOW:
            [self YSCALayer:nil];
            break;
        case LAYER_DRAW:
            [self CALayerDray:nil];
            break;
        case LAYER_CUSTOM:
            [self CutomDraw:nil];
            break;
        case ANIMATION_CORE:
            [self coreAnimation:nil];
            break;
        case ANIMATION_VALUES:
            [self setAnimationAsValue:nil];
            break;
        case ANIMATION_PATH:
            [self setAnimationAsPath:nil];
            break;
        case ANIMATION_ARR:
            [self animationArr];
            break;
        case ANIMATION_CUTTO:
            [self animationCutTo];
            break;
        case ANIMATION_CAD:
            [self animationCADLink];
            break;
        case ANIMATION_UIVIEW:
            [self uiViewAnimation];
            break;

        default:
            break;
    }

}

#pragma mark- _tableViewDataSource code
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return   _dataArray.count;
    
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
    cell.detailTextLabel.text = _subArray[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -跳转
- (IBAction)YSCALayer:(id)sender {
    _YSCtr = [[YSLayerViewController alloc] init];
    [self.navigationController pushViewController:_YSCtr animated:YES];
}

- (IBAction)CALayerDray:(id)sender {
     _DRCtr = [[DRCALayerViewController alloc] init];
    [self.navigationController pushViewController:_DRCtr animated:YES];
}

- (IBAction)CutomDraw:(id)sender {
    _CCtr =[[CutomViewController alloc] init];
    [self.navigationController pushViewController:_CCtr animated:YES];
    
}

- (IBAction)coreAnimation:(id)sender {
    _CACtr = [[CoreAnimationViewController alloc] init];
    [self.navigationController pushViewController:_CACtr animated:YES];
    
}

- (IBAction)setAnimationAsValue:(id)sender {
    _VaCtr = [[AnimationValuesViewController alloc] init];
    [self.navigationController pushViewController:_VaCtr animated:YES];
}

- (IBAction)setAnimationAsPath:(id)sender {
    _PaCtr = [[AnimationPathViewController alloc] init];
    [self.navigationController pushViewController:_PaCtr animated:YES];
}
- (void)animationArr{
    _aniArrCtr = [[AnimationsArrViewController alloc] init];
    [self.navigationController pushViewController:_aniArrCtr animated:YES];

}
- (void)animationCutTo{
   // _cutCtr = [[CutToViewController alloc] init];
    _fCtr = [[FamilyTurnViewController alloc] init];
    [self.navigationController pushViewController:_fCtr animated:YES];
    
}

- (void)animationCADLink
{
    _CADCtr= [[CADisplayLinkViewController alloc] init];
    [self.navigationController pushViewController:_CADCtr animated:YES];
}

 - (void)uiViewAnimation
{
    _UIVCtr = [[UIViewAnimationViewController alloc] init];
    
    [self.navigationController pushViewController:_UIVCtr animated:YES];
}

@end
