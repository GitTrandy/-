//
//  JKImageData.h
//  娱乐宝
//
//  Created by Zhang_JK on 15/6/5.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKImageData : NSObject

#pragma mark 索引
@property (nonatomic,assign)int index;

#pragma mark 图片数据
@property (nonatomic,strong)NSData *data;

@end
