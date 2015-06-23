//
//  IDCardViewController.h
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/28.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDCardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cardTextFiled;

@property (weak, nonatomic) IBOutlet UILabel *statusLab;
- (IBAction)check:(id)sender;

@end
