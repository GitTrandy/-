//
//  JKCheck.h
//
//
//  Created by Zhang_JK on 15/5/26.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//  正则表达式

#import <Foundation/Foundation.h>

@interface JKCheck : NSObject

//邮箱
+ (BOOL)validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL)validateMoblie:(NSString *)moblie;

//车牌号验证
+ (BOOL)validateCardNo:(NSString *)cardNo;

//车型
+ (BOOL)validateCarType:(NSString *)CarType;

//用户名
+ (BOOL)validateUserName:(NSString *)name;

//密码
+ (BOOL)validatePassword:(NSString *)password;

//昵称
+ (BOOL)validateNickName:(NSString *)nickName;

//身份证号
+ (BOOL)validateIdentityCard:(NSString *)IdentityCard;

//身份证2
+ (BOOL)validateIDCardNumber:(NSString *)value;


@end
