//
//  Person.h
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/19.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
@interface Person : NSObject
{
    Dog *dog;
}
@property (nonatomic,strong)Dog *dog;
@end
