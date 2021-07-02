//
//  NSString+NCDate.h
//  NatureCard
//
//  Created by zhongzhi on 2017/8/18.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NCDate)
+(NSTimeInterval)timeIntervalFromTimeStr:(NSString *)timeStr withFormater:(NSString *)formater; //时间转换为时间戳
+(NSString *)formateDate:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateForLong:(long)second formatter:(NSString *)fomatter;//时间戳转换为时间

+(NSTimeInterval)getNowInterVal;//获取当前的时间戳
+(NSString *)getNowTime;//获取当前的时间字符串
+(NSString *)formateDateToDay:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateOnlyYueri:(NSString *)string;//时间戳转换为时间
+(NSString *)formateDateOnlyShifen:(NSString *)string;//时间戳转换为时间

+(NSDate *)dateFromTimeStr:(NSString *)timeStr;//年月日转换为date;

+(NSString *)ret32bitString;//随机的32位字符串

// 将年月日时分秒时间转化成任意格式
-(NSString *)timeFromUTCTimeToFormatter:(NSString *)formatterString;
// 将年月日时间格式转化成任意格式
- (NSString *)timeFromUTCDateToFormatter:(NSString *)formatterString;
///UTC 手机本地当前时间
+ (NSString *)getUTCFormateLocalDate;

// 将一种时间格式转化成另一种格式
- (NSString *)timeFromUTCTimeFromFromatter:(NSString *)fromMatterString ToFormatter:(NSString *)formatterString;


// 将秒转换为时间,含天数
+ (NSString *)secondTransToDate:(NSInteger)totalSecond;

+ (NSAttributedString *)attStringSecondTransToDate:(NSInteger)totalSecond ;


+ (NSString *)compareCurrentTime:(NSString *)str;

+ (NSString *)compareTodayDateCurrentTime:(NSString *)str;

@end
