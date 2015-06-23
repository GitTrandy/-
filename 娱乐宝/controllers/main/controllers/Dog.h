//
//  Dog.h
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/19.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject
{
    int _ID;
    NSTimer *timer;
    int barkCount;
    
    //定义一个blocks的变量
    void(^BarkCallBack)(Dog *thisDog,int count);
    
}
@property (assign) int ID;

- (void)setBark:( void(^)(Dog *thisDog,int count))eachBark;
//向外暴露了一个函数 setBark


@end
