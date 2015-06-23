//
//  NextViewController.h
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/21.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//



#import <UIKit/UIKit.h>

//声明返回值为空得blocks函数
typedef void (^textBlocks)(UITextField *textField);
typedef int (^BringBlocks)(UITextField *textField,NSString *text,NSInteger index);
typedef void (^NewBlock)(int BRBlocks);
@protocol NextViewControllerDelegate <NSObject>

@required
- (void)setTitleWith:(NSString *)textFieldString;
@optional
- (void)setButtonTitle:(NSString *)tilte;


@end

@interface NextViewController : UIViewController
{
    //声明一个blocks变量
    textBlocks blocks1;
    BringBlocks BrBlocks;
    NewBlock newBlock1;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITextField *identityCardTF;
@property (nonatomic,weak) id<NextViewControllerDelegate>delegate;
//@property (nonatomic,weak)textBlocks(blocks);

- (void)setFieldText:(BringBlocks)brBlocks;
- (void)setText:(textBlocks)block;
- (void)setNewBlocks:(NewBlock)newBlock;
- (instancetype)initCompletion:(textBlocks)block;

@end
