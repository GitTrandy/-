//
//  PlistViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/24.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

//plist的创建，数据写入与读取
#import "PlistViewController.h"

@interface PlistViewController ()
- (IBAction)triggerStorage:(id)sender;

@end

@implementation PlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"path is %@",path);
    NSString *fileName = [path stringByAppendingString:@"test.plist"];
    
    //设置属性
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
    [dictplist setObject:@"欧阳峰" forKey:@"name"];
    //写入文件
    [dictplist writeToFile:fileName atomically:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)triggerStorage:(id)sender {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"path is %@",path);
    NSString *fileName = [path stringByAppendingString:@"test.plist"];
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
    NSString *str = [dictplist objectForKey:@"name"];
    self.displayLab.text = str;
    
}
@end
