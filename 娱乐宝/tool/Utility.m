//
//  Utility.m
//  娱乐宝
//
//  Created by Zhang_JK on 15/5/20.
//  Copyright (c) 2015年 Zhang_JK. All rights reserved.
//

#import "Utility.h"

@implementation Utility

#pragma mark -
#pragma mark -System Code
+(AppDelegate *)delegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
/*
 *@DO返回IOS系统版本号
 */
+(CGFloat)isVerson{
    return [[[UIDevice currentDevice] systemVersion] floatValue];

}

/*
 *@DO返回IOS系统语言
 */
+(NSString *)iosLanguage{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    return [languages objectAtIndex:0];

}


#pragma mark -
#pragma mark NSString Code

/*
 *@DO 获取指定标题的颜色
 *@param colorTilte 指定颜色
 *@return UIColor
 */
+ (UIColor *)colorForTitle:(NSString *)colorTitle{
    
    UIColor* color = nil;
    if ([colorTitle isEqualToString:BACKGROUND])
    {//总背景色
        color = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:TINT])
    {//NAVIGATION(导航条)
        //color = [UIColor colorWithRed:161.0f/255.0f green:0.0f/255.0f blue:8.0f/255.0f alpha:1.0f];
        color = [UIColor lightGrayColor];
    }
    if ([colorTitle isEqualToString:BORDER])
    {//边框
        color = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:ODD])
    {//奇数行
        color = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:EVEN])
    {//偶数行
        color = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:OUTBORDER])
    {//外边框
        color = [UIColor colorWithRed:179.0/255.0f green:179.0/255.0f blue:179.0/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:INBORDER])
    {//内边框
        color = [UIColor colorWithRed:217.0/255.0f green:217.0/255.0f blue:217.0/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:FILL])
    {//表格填充
        color = [UIColor colorWithRed:238.0/255.0f green:238.0/255.0f blue:238.0/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:TBFONT])
    {//表格内文字
        color = [UIColor colorWithRed:97.0/255.0f green:97.0/255.0f blue:97.0/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:REDBORDER])
    {//红色边框
        color = [UIColor colorWithRed:217.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:GRAY])
    {//红色边框
        color = [UIColor colorWithRed:70.0/255.0f green:70.0/255.0f blue:70.0/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:@"navColor"])
    {//
        color = [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:176.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:@"line1"])
    {//
        color = [UIColor colorWithRed:255.0f/255.0f green:60.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:@"line2"])
    {//
        color = [UIColor colorWithRed:243.0f/255.0f green:126.0f/255.0f blue:22.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:@"line3"])
    {//
        color = [UIColor colorWithRed:137.0f/255.0f green:12.0f/255.0f blue:8.0f/255.0f alpha:1.0f];
    }
    
    if ([colorTitle isEqualToString:@"cellColor"])
    {//
        color = [UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:@"baseColor"])
    {
        color = [UIColor colorWithRed:161.0f/255.0f green:0.0f/255.0f blue:8.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:RECTBG])
    {
        //矩形背景色--财经资讯
        color = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1.0f];
    }
    if ([colorTitle isEqualToString:TVSEL])
    {
        //TABLEVIEW CELL选中的背景色
        color = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
    }
    if([colorTitle isEqualToString:@"pie1"])
    {
        color = [UIColor colorWithRed:68.0f/255.0f green:113.0f/255.0f blue:165.0f/255.0f alpha:1];
    }
    if([colorTitle isEqualToString:@"pie2"])
    {
        color = [UIColor colorWithRed:168.0f/255.0f green:69.0f/255.0f blue:66.0f/255.0f alpha:1];
    }
    if([colorTitle isEqualToString:@"pie3"])
    {
        color = [UIColor colorWithRed:135.0f/255.0f green:163.0f/255.0f blue:77.0f/255.0f alpha:1];
    }
    if([colorTitle isEqualToString:@"pie4"])
    {
        color = [UIColor colorWithRed:112.0f/255.0f green:87.0f/255.0f blue:141.0f/255.0f alpha:1];
    }
    if([colorTitle isEqualToString:@"pie5"])
    {
        color = [UIColor colorWithRed:64.0f/255.0f green:150.0f/255.0f blue:173.0f/255.0f alpha:1];
    }
    if([colorTitle isEqualToString:@"pie6"])
    {
        color = [UIColor colorWithRed:217.0f/255.0f green:130.0f/255.0f blue:60.0f/255.0f alpha:1];
    }
    if([colorTitle isEqualToString:@"pie7"])
    {
        color = [UIColor colorWithRed:145.0f/255.0f green:167.0f/255.0f blue:205.0f/255.0f alpha:1];
    }
    if([colorTitle isEqualToString:@"pie8"])
    {
        color = [UIColor colorWithRed:207.0f/255.0f green:145.0f/255.0f blue:144.0f/255.0f alpha:1];
    }
    if([colorTitle isEqualToString:@"pie9"])
    {
        color = [UIColor colorWithRed:183.0f/255.0f green:203.0f/255.0f blue:148.0f/255.0f alpha:1];
    }
    if([colorTitle isEqualToString:@"Mint"])
    {
        color = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1];
    }
    return color;
}
/*
 *@DO md5加密
 *@param str 要加密的文本
 *@return NSString;
 */

+ (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/*
 *@DO 去掉字符串左右两侧的空格
 *@param str 要格式化的文本
 *@return NSString;
 */
+ (NSString *)trim:(NSString *)str{
    if (nil==str)
        return nil;
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
}

/*
 *@DO 判断字符串是否为空串其中空串是指经过trim后的字符串的长度为0
 *@param str
 *@return 空串或空返回YES、否则返回NO;
 */

+ (BOOL) isBlank:(NSString *)str{
    str = [Utility trim:str];
    if (nil==str||[@"" isEqualToString:str]) {
        return YES;
    }
    return NO;

}

/*
 *@DO 判断字符串是否为非空串，其中空串是指经过trim后的字符串的长度为0
 *@param str 要加密的文本
 *@return 空串或空返回NO、否则返回YES;
 */
+ (BOOL) notBlank:(NSString *)str{
    return ![Utility isBlank:str];

}

/*
 *@DO 将整数格式化为字符串
 *@param code
 *@return NSString;
 */

+ (NSString *)int2Str:(NSInteger)code{
    return [NSString stringWithFormat:@"%ld",(long)code];


}
/*
 *@DO 判断字符串string是否包含str
 *@param string
 *@param str
 *@return 包含YES|非包含NO
 */

+ (BOOL)string:(NSString *)strs contain:(NSString *)str{
    if ([Utility isBlank:strs]) {
        return NO;
    }
    if ([Utility isBlank:str]) {
        return NO;
    }
    NSRange rangeIndex = [strs rangeOfString:str options:NSCaseInsensitiveSearch];
    if (rangeIndex.length>0) {
        return YES;
    }else {
        return NO;
    }

}
+ (BOOL)stringEquals:(NSString *)str1 to:(NSString *)str2{
    if (str1==nil||str2 ==nil) {
        return NO;
    }
    return[str1 compare:str2 options:NSCaseInsensitiveSearch]==NSOrderedSame;
    
}

+ (BOOL)caseEquals:(NSString *)str1 to:(NSString *)str2{
    return (str1 ==nil||str2==nil)?NO:[str1 isEqualToString:str2];

}
/*
 *@DO 判断某个字符串是否以prefix开始
 *
 */

+ (BOOL)startWith:(NSString *)prefix forString:(NSString *)text{
 
    if (prefix!=nil&&text!=nil) {
        if (prefix.length>text.length) {
            return NO;
        }
        NSString *prestr = [text substringToIndex:[prefix length]];
        if ([Utility stringEquals:prestr to:prestr]) {
            return YES;
        }
    }
    return NO;

}
/*
 *@DO 判断某个字符串是否以suffix结尾
 *
 */

+ (BOOL)endWith:(NSString *)suffix forString:(NSString *)text{
    if (text!=nil&&text!=nil) {
        if (suffix.length>text.length) {
            return NO;
        }
        NSInteger len = [text length]-[suffix length];
        NSString *sufStr = [text substringFromIndex:len];
        if ([Utility caseEquals:sufStr to:suffix]) {
            return YES;
        }
    }
    
    return NO;

}

/*
 *@DO 判断某个字符串是否全部是数字
 */
+ (BOOL)stringIsAllNumber:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (string.length>0) {
        return NO;
    }
    return YES;

}

#pragma mark -
#pragma mark - NSDate Code

+ (NSString *)converToString:(double)num{
    NSNumberFormatter *numberFamatter = [[NSNumberFormatter alloc] init];
    [numberFamatter setPositiveFormat:@"###,##0.00;"];
    NSString *formatterNumberString = [numberFamatter stringFromNumber:[NSNumber numberWithDouble:num]];
    
    return formatterNumberString;

}


/*
 *  @DO 将日期格式化为指定格式的字符串
 *  @param date [要格式化的日期]
 *  @param patten   [日期格式]
 *  @return
 */
+ (NSString *)date2Str:(NSDate *)date patten:(NSString *)patten{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:patten];
    NSString *str = [dateFormatter stringFromDate:date];
    return str;

}
/*
 *  @DO 将当前日期为指定格式的字符串
 *  @param date [要格式化的日期]
 *  @param patten   [日期格式]
 *  @return
 */

+ (NSString *)currentDatetimeWithPatten:(NSString *)patten{
    if ([Utility isBlank:patten]) {
        patten = kDefaultDatetimePatten;
    }
    
    return [Utility date2Str:[NSDate date] patten:patten];
    

}
/*
 *  @DO 将当前日期
 *
 *  @return
 */

+ (NSString *)currentDateTime{
    return [Utility currentDatetimeWithPatten:kDefaultDatetimePatten];


}

/*
 *  @DO将当前时间格式化为指定格式的字符串
 *  @param patten   [时间格式]
 *  @return
 */
+ (NSString *)currentTimeWithPatten:(NSString *)patten{
    if ([Utility isBlank:patten]) {
        patten = kDefaultTimePatten;
    }
    return [Utility date2Str:[NSDate date] patten:patten];

}

/*
 *  @DO将当前时间
 *  @return
 */
+ (NSString *)currentTime{
    return [Utility currentTimeWithPatten:kDefaultTimePatten];

}

/*
 *  @DO将字符串格式化为日期
 *  @return
 */


+ (NSDate *)str2Date:(NSString *)str patten:(NSString *)patten{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:patten];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}

+ (NSDate *)str2DateTime:(NSString *)str patten:(NSString *)patten{
    if ([Utility isBlank:patten]) {
        patten = kDefaultTimePatten;
    }
    return [Utility str2Date:str patten:patten];


}

+ (NSDate *)str2Date:(NSString *)str{
    return [Utility str2Date:str patten:kDefaultDatetimePatten];

}

+ (NSString *)datetime2time:(NSString *)datetime{
    NSDate *date = [Utility str2DateTime:datetime
                                  patten:kDefaultDatetimePatten];
    return [Utility date2Str:date patten:kDefaultTimePatten];

}

/*
 * @DO 两个日期之间的差值
 * @param oneYear
 * @param twoYear
 * @return int
 */

+ (NSInteger)minBetweenOneDate:(NSString *)oneDate
                       twoDate:(NSString *)twoDate{
    
    NSInteger between = 0;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:(@"yyyy-MM-dd HH:mm:ss")];
    NSDate *dateOne = [formatter dateFromString:oneDate];
    NSDate *dateTwo = [formatter dateFromString:twoDate];
    between = [dateOne timeIntervalSinceDate:dateTwo];
    return between;
    

}

+ (NSInteger)minuteBetweenOneDate:(NSString *)oneDate
                          twoDate:(NSString *)twoDate{
    
    NSInteger bettween = 0;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:(@"yyyy-MM-dd HH:mm:ss")];
    NSDate *dateOne = [formatter dateFromString:oneDate];
    NSDate *dateTwo = [formatter dateFromString:twoDate];
    bettween = [dateOne timeIntervalSinceDate:dateTwo];
    
    return bettween;


}

+ (NSTimeInterval)timeIntervalFirstTime :(NSString *)firstTime
                              secondTime:(NSString *)secondTime{
    NSInteger timeInterval = 0;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone defaultTimeZone]];
    [format setDateFormat:(@"yyyy-MM-dd HH:mm:ss")];
    NSDate *firstDate = [format dateFromString:firstTime];
    NSDate *secondDate = [format dateFromString:secondTime];
    timeInterval = [firstDate timeIntervalSinceDate:secondDate];
    return timeInterval;

}

+ (NSString *)anotherSystemTime:(NSTimeInterval )timeInterval{
    NSDate *theDate = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];
    NSString *theDateStr = [NSString stringWithString:[Utility date2Str:theDate patten:kDefaultDatetimePatten]];
    
    
    return theDateStr;

}

#pragma mark -
#pragma mark NSURL Code
+ (NSString *)formatURLStr:(NSString *)str{
    return nil;

}
+ (NSString *)interface:(NSString *)interface
                 params:(NSMutableDictionary *)params{
    return nil;


}


#pragma mark -
#pragma mark UIKit Code

+ (void)alert:(NSString *)message
        title:(NSString *)title
       buttom:(NSString *)button{
    
    

}

+ (void)alert:(NSString *)message
        title:(NSString *)title{

}

+ (void)alert:(NSString *)message{

}
+ (void)tkAlert:(NSString *)message
      imageName:(NSString *)imageName{

}
+ (void)blockBorderWith:(UIView *)view{

}
+ (UIColor *)color16:(NSString *)color{
    return nil;

}
+ (void)borderView:(UIView *)view
      cornerRadius:(CGFloat)cornerRadius
             width:(CGFloat)width
             color:(UIColor *)color{

}
+ (void)defaultBorder:(UIView *)view{

}
#pragma mark-
#pragma mark -alert
+ (void)showAlwetWithTitle:(NSString *)title
                   content:(NSString *)content
              cancelButton:(NSString *)cancel{

}


@end
