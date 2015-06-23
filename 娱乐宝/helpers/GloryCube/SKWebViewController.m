//
//  SKWebViewController.m
//  SimpleKit
//
//  Created by SimpleKit on 12-6-25.
//  Copyright (c) 2012年 SimpleKit. All rights reserved.
//

#import "SKWebViewController.h"

@interface SKWebViewController ()

@property (nonatomic, retain) NSMutableArray *webs; // 网页视图对象的集合
@property (nonatomic, retain) UIActivityIndicatorView *indicator; // 右上角显示页面加载的视图

- (void)initData;
- (void)initView;

@end

@implementation SKWebViewController

#pragma mark -
#pragma mark Public Attribute
@synthesize urlDatas = _urlDatas;
@synthesize segWidth = _segWidth;
@synthesize isNeedRelogin = _isNeedRelogin;

#pragma mark -
#pragma mark Private Attribute
@synthesize webs = _webs;
@synthesize indicator = _indicator;

#pragma mark -
#pragma mark Public Code

#pragma mark -
#pragma mark Delegate Code
- (void)webToolBar:(SKWebToolBarItem *)webTool buttonDidClickAtIndex:(NSInteger)index webToolBarType:(SKWebToolBarItemType)type 
{
    if (type == SKWebToolBarItemTypeWebTool) {
        switch (index) {
            case 0:
            {
                [(UIWebView *)[self view] goBack];
            }
                break;
            case 1:
            {
                [(UIWebView *)[self view] goForward];
            }
                break;
            case 2:
            {
                [(UIWebView *)[self view] reload];
            }
                break;
            case 3:
            {
                //                NSURL *url = [NSURL URLWithString:[_tabUrls objectAtIndex:_segmentedControl.selectedSegmentIndex]];
                NSInteger i = [(UISegmentedControl *)self.navigationItem.titleView selectedSegmentIndex];
                NSURL *url = [NSURL URLWithString:[[_urlDatas objectAtIndex:i] objectAtIndex:2]];
                NSURLRequest *req = [NSURLRequest requestWithURL:url];
                [(UIWebView *)[self view] loadRequest:req];
            }
                break;
            case 4:
            {
                NSInteger i = [(UISegmentedControl *)self.navigationItem.titleView selectedSegmentIndex];
                NSURL *url = [NSURL URLWithString:[[_urlDatas objectAtIndex:i] objectAtIndex:1]];
                NSURLRequest *req = [NSURLRequest requestWithURL:url];
                [(UIWebView *)[self view] loadRequest:req];
            }
                break;
            default:
                break;
        }
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"... Request URL : %@", request.URL);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_indicator startAnimating];
    
    //    [self.view addSubview:_progress];
    //    [_progress show:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_indicator stopAnimating];
    
    //    [_progress hide:YES];
    [self enableBackAndForward];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    NSLog(@"... didFailLoadWithError: %@; error code: %d", error, [error code]);
    
    if ([error code] == -1001) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"网络请求超时，请检查网络"
                                                       delegate:nil
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil, nil];
        //[alert setShowTime:10];
        [alert show];
        [alert release];
        
        return;
    }
}

#pragma mark -
#pragma mark Private Code
- (void)initData {
    if (self.urlDatas == nil) {
        self.urlDatas = [NSArray arrayWithObjects:
                         [NSArray arrayWithObjects:@"百度", @"http://www.baidu.com", @"http://www.baidu.com", nil],
                         [NSArray arrayWithObjects:@"谷歌", @"http://www.google.com", @"http://www.google.com", nil],
                         nil];
        //        self.urlDatas = [NSArray arrayWithObjects:
        //                         [NSArray arrayWithObjects:
        //                          @"知识库", 
        //                          @"http://10.200.16.5:7001/kmiam/login?masterAcc=714995&slaveAcc=714995&staticPwd=Ad52JIBY%2BBAnMfDo1YeEBA==", 
        //                          @"http://10.200.16.5:7001/index.php",
        //                          nil],
        //                         [NSArray arrayWithObjects:
        //                          @"路透资讯", 
        //                          @"http://ceb.reuterspwm.com", 
        //                          @"http://ceb.reuterspwm.com/ceb/pages/0/0/cn.jsp?pageID=0.0.0",
        //                          nil], 
        //                         nil];
    }
}

- (void)initView {
    
    self.webs = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < [_urlDatas count]; i++) {
        UIWebView *web = [[[UIWebView alloc] init] autorelease];
        [web setScalesPageToFit:YES];
        [web setDelegate:self];
        NSURL *url = [NSURL URLWithString:[[_urlDatas objectAtIndex:i] objectAtIndex:1]];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [web loadRequest:req];
        [_webs addObject:web];
    }
    
    UIWebView *web = [_webs objectAtIndex:0];
    [web setScalesPageToFit:YES];
    [web setDelegate:self];
    [self setView:web];
    
    self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)] autorelease];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [_indicator setColor:[UIColor blackColor]];
    }
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithCustomView:_indicator] autorelease];
    self.navigationItem.rightBarButtonItem = item;
    //[_indicator startAnimating];
    
    //    NSLog(@">>> self.urlDatas: %@", self.urlDatas);
    
    //    NSURL *url = [NSURL URLWithString:[[self.urlDatas objectAtIndex:0] objectAtIndex:1]];
    //    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    //    [web loadRequest:req];
}

/*
 初始化导航条上的各组建
 */
- (void)initNavViews {
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"InfoSegmentText" ofType:@"plist"];
    //    NSArray *titles1 = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < [_urlDatas count]; i++) {
        [titles addObject:[[_urlDatas objectAtIndex:i] objectAtIndex:0]];
    }
    
    UISegmentedControl *segmentedControl = [[[UISegmentedControl alloc] initWithItems:titles] autorelease];
    segmentedControl.frame = CGRectMake(0, 0, _segWidth, 30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    //segmentedControl.momentary = YES;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self
                         action:@selector(valueChangedWithSegment:)
               forControlEvents:UIControlEventValueChanged
     ];
    self.navigationItem.titleView = segmentedControl;
    
    CGRect toolBarRect = CGRectMake(-0, 0, 270, 44);
    
    NSArray *actions = nil;
    if (_isNeedRelogin) {
        actions = [NSArray arrayWithObjects:@"回到首页", @"超时认证", nil];
    } else {
        actions = [NSArray arrayWithObjects:@"回到首页", nil];
    }
    
    SKWebToolBarItem *barItem = [[[SKWebToolBarItem alloc] initWithFrame:toolBarRect controller:self actionTitles:actions buttonTitles:[NSArray arrayWithObjects:@"11111", @"22222", nil]] autorelease];
    barItem.delegate = self;
    
    self.navigationItem.leftBarButtonItem = barItem;
    
    [(SKWebToolBarItem *)self.navigationItem.leftBarButtonItem setToolType:(SKWebToolBarItemTypeWebTool)];
    
    [(SKWebToolBarItem *)self.navigationItem.leftBarButtonItem back].enabled = NO;
    [(SKWebToolBarItem *)self.navigationItem.leftBarButtonItem forward].enabled = NO;
}

- (void)enableBackAndForward {
    if ([(UIWebView *)[self view] canGoBack]) {
        [(SKWebToolBarItem *)self.navigationItem.leftBarButtonItem back].enabled = YES;
    } else {
        [(SKWebToolBarItem *)self.navigationItem.leftBarButtonItem back].enabled = NO;
    }
    
    if ([(UIWebView *)[self view] canGoForward]) {
        [(SKWebToolBarItem *)self.navigationItem.leftBarButtonItem forward].enabled = YES;
    } else {
        [(SKWebToolBarItem *)self.navigationItem.leftBarButtonItem forward].enabled = NO;
    }
}

/*
 响应SegmentedControl值发生改变
 */
- (void)valueChangedWithSegment:(UISegmentedControl *)seg {
    
    //    NSLog(@"selectedSegmentIndex: %d", seg.selectedSegmentIndex);
    
    UIWebView *web = [_webs objectAtIndex:seg.selectedSegmentIndex];
    [self setView:web];
    [self enableBackAndForward];
    
    //    NSURL *url = [NSURL URLWithString:[[_urlDatas objectAtIndex:seg.selectedSegmentIndex] objectAtIndex:1]];
    //    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    //    [(UIWebView *)[self view] loadRequest:req];
    
    //    switch (seg.selectedSegmentIndex) {
    //        case 0:
    //        {
    //            [self loadView:_puyi toolType:SKWebToolBarItemTypeWebTool];
    //            
    //            [self enableBackAndForward];
    //        }
    //            break;
    //        case 1:
    //        {
    //            static BOOL isFirst = YES;
    //            
    //            if (isFirst) {
    //                [self loadUrl:[_urlMap objectForKey:@"klLogin"]
    //                      webView:_lutou
    //                     toolType:SKWebToolBarItemTypeWebTool
    //                 ];
    //                
    //                isFirst = NO;
    //            } else {
    //                [self loadView:_lutou toolType:SKWebToolBarItemTypeWebTool];
    //            }
    //            
    //            [self enableBackAndForward];
    //        }
    //            break;
    //        default:
    //            break;
    //    }
}

#pragma mark -
#pragma mark Super Code
- (id)init {
    self = [super init];
    if (self) {
        // Custom initialization
        self.segWidth = 140;
        self.isNeedRelogin = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        self.segWidth = 140;
        self.isNeedRelogin = NO;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.segWidth = 140;
        self.isNeedRelogin = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initData];
    [self initView];
    [self initNavViews];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return YES;
}

- (void)dealloc {
    [_urlDatas release];
    [_webs release];
    [_indicator release];
    [super dealloc];
}

@end
