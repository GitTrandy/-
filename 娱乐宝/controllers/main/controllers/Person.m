//
//  Person.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/19.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "Person.h"
#import "Dog.h"
@implementation Person
@synthesize dog = _dog;
- (void)setDog:(Dog *)dog
{
    if (_dog !=dog){
        _dog = [[Dog alloc] init];
        
        [_dog setBark:^(Dog *thisDog, int count) {
            NSLog(@"person dog %d count %d",[thisDog ID],count);
            
        }];

    }
}

- (Dog *)dog
{
    return _dog;
}
@end
