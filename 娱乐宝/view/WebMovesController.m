//
//  WebMovesController.m
//  推送测试
//
//  Created by Zhang_JK on 15/3/30.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#define kWIDTH 320
#define kHIGHT 570

#import "WebMovesController.h"
#import "MBProgressHUD.h"
@interface WebMovesController ()
<
UIWebViewDelegate
>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation WebMovesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _webView = [[UIWebView alloc] init];
    _webView.frame = CGRectMake(0, 0,kWIDTH, kHIGHT);
    _webView.userInteractionEnabled = YES;
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
    
    [self.view addSubview:_webView];
    [_webView setScalesPageToFit:YES];
    [_webView setOpaque:YES];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"]=@"北京";
    params[@"category"]=@"KTV";
    params[@"userName"]=@"张己宽";
    params[@"server"]=@"http://39.0.16.98";
    params[@"moneyCount"]=@"100000";
    params[@"userID"]=@"372923198912034410";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.webURL]];
    

}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

//    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
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
