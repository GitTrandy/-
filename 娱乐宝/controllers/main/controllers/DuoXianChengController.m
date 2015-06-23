//
//  DuoXianChengController.m
//  娱乐宝
/*
 
 在开发过程中应该尽可能的减少用户等待时间，让程序尽可能的快的完成计算。可是无论是哪种语言开发的
 程序最终往往转换成汇编语言进而解释成机器码来执行。但是机器码是按顺序执行的，一个复杂多不操作只能
 一步步按顺序来执行。改变这种状况可以从两个角度出发：对于单核处理器，可以将多个步骤放到不同的线程
 ，这样一来用户完成UI操作后其他后续任务在其他线程中，当CPU空闲时会执行，而此时对于用户而言可以继续其他操作，对于多核处理器，如果用户在UI线程中完成其他UI操作，与此同时前一个操作的后续任务可以
 分散到多个CPU中继续执行（当然具体调度顺序应根据程序设计而定），即解决了线程阻塞又提高了运行
 效率。苹果从iPad2开始使用A5处理器（iPhone中从iPhone4s开始使用），A7中还加入了协处理器，如何让
 充分发挥这些处理器值得思考。本例重点分析IOS多线程开发
 
 */
//
//  Created by Zhang_JK on 15/6/5.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//  多线程并行开发

/*
 多线程简介
 当用户播放音频、下载资源、进行图像处理的时候往往希望做这些事的时候其他操作不会被中断或者希望这些操作过程中更加流畅。在单线程中
 一个线程只能做一件事情，一件事情处理不完另一件事情就不能开始，这样势必会影响用户体验。早在单核处理器时期就有多线程，这个时候的多线程
 更多的解决线程阻塞造成的用户等待（通常是操作完UI后用户不再干涉，其他线程在等待队列中，CPU一空闲就继续执行、不影响用户其他操作）；
 其处理能力并没有明显的变化。如今无论是移动系统还是PC，服务器都是多核处理器，于是“并行运算”就更多地被提及。一件事情我们可以分为多个
 步骤，在没有顺序要求的情况下，使用多线程既能解决线程阻塞又能充分利用多核处理器运行能力
 
 在IOS中每个进程启动后都会建立一个主线程（UI线程），这个线程是其他线程的父线程。由于ios中除了主线程其他线程是独立于Cocoa Touch
 的，所以只有主线程可以更新UI界面（新版Ios中，使用其他线程更新UI可能也能成功，但不推荐）。ios多线程并不复杂，关键是如何让控制好
 各个线程的执行顺序、处理好资源竞争问题。
 
 
 */

#import "DuoXianChengController.h"
#import "NSThreadViewController.h"
@interface DuoXianChengController ()

@end

@implementation DuoXianChengController
{
    NSMutableArray *_dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    _dataArray = [[NSMutableArray alloc] initWithObjects:
                  @"NSThread",
                  @"NSOperation",
                  @"GCD" ,nil];
    

    
    

    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *identiy = @"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identiy];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identiy];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
    
}
#pragma mark TabViewDelegate code
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    switch (index) {
        case 0:
            [self jump2NSThread];
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)jump2NSThread
{
    NSThreadViewController *nCtr = [[NSThreadViewController alloc] init];
    [self.navigationController pushViewController:nCtr animated:NO];
    
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
