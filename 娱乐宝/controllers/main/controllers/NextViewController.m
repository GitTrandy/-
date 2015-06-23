//
//  NextViewController.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/21.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "NextViewController.h"
#import "JKCheck.h"
@interface NextViewController ()
- (IBAction)returnBack:(id)sender;

@end

@implementation NextViewController

- (instancetype)initCompletion:(textBlocks)block;
{
    self = [super init];
    if (self) {
        blocks1 = [block copy];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNewBlocks:(NewBlock)newBlock
{
    newBlock1 = [newBlock copy];
}
- (void)setFieldText:(BringBlocks)brBlocks
{
    BrBlocks =[brBlocks copy];
    
}

- (void)setText:(textBlocks)block
{
    blocks1 = [block copy];
}
- (IBAction)returnBack:(id)sender {
    if ([_delegate performSelector:@selector(setTitleWith:) withObject:self.textField.text]) {
        [_delegate setTitleWith:self.textField.text];
    }
    BringBlocks brBlocks =^(UITextField *textField,NSString *text,NSInteger index){
        
        return 30;
    };
    
    blocks1 (_textField);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)checkIdentityCard:(id)sender {
    
    NSString *identy = _identityCardTF.text;
    if ([JKCheck validateIdentityCard:identy]) {
        NSLog(@"身份证信息正确");
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"身份证信息正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    } else {
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"身份证信息错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    }
    
}
//身份证号
-(BOOL)validateIdentityCard:(NSString *)identityCard{
    BOOL flag;
    if (identityCard.length<=0) {
        flag=NO;
        return flag;
    }
    NSString *regex2 =@"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
    
}
@end
