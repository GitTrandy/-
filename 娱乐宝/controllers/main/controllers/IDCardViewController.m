//
//  IDCardViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/28.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "IDCardViewController.h"
#import "JKCheck.h"
#import "SKAlertView.h"
@interface IDCardViewController ()

@end

@implementation IDCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)check:(id)sender {
    if ([JKCheck validateIDCardNumber:_cardTextFiled.text]) {
        _statusLab.text = @"身份证信息正确";
        SKAlertView *skAlert = [[SKAlertView alloc]
                                initWithTitle:@"友情提示"
                                message:_statusLab.text
                                delegate:nil
                                cancelButtonTitle:nil
                                otherButtonTitles:nil, nil];
        skAlert.showTime=2;
        [skAlert show];
        
    }else {
        _statusLab.text = @"身份证信息错误";

        SKAlertView *skAlert = [[SKAlertView alloc]
                                initWithTitle:@"友情提示"
                                message:_statusLab.text
                                delegate:nil
                                cancelButtonTitle:nil
                                otherButtonTitles:nil, nil];
        skAlert.showTime=2;
        [skAlert show];
        

    }
}
@end
