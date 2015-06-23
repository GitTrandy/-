//
//  Dog.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/19.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "Dog.h"
#import "Person.h"
@implementation Dog
@synthesize ID= _ID;

- (id)init
{
    self = [super init];
    if (self) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self
                                               selector:@selector(updateTimer:)
                                               userInfo: nil
                                                repeats:YES];
    }
    return self;
}

- (void)setBark:( void(^)(Dog *thisDog,int count))eachBark{
    BarkCallBack = [eachBark copy];
    
}

- (void)updateTimer:(id)arg
{
    barkCount++;
//    NSLog(@"dog %d bark count %d",_ID,barkCount);
    //给person/xiaoli 汇报一下
    //调用Person、xiaoLi里面的Blocks
    if (BarkCallBack) {
        BarkCallBack(self,barkCount);
        //调用从person穿过来的blocks
        
    }
    
}

@end
