//
//  NSString+Base64.m
//  rsa
//
//  Created by wzk on 2017/12/29.
//  Copyright © 2017年 lihe. All rights reserved.
//

#import "NSString+Base64.h"
#import "NSData+Base64.h"
@implementation NSString (Base64)
+ (NSString *)stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        NSString *result = [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
#if !__has_feature(objc_arc)
        [result autorelease];
#endif
        
        return result;
    }
    return nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data base64EncodedString];
}

- (NSString *)base64DecodedString
{
    return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData
{
    return [NSData dataWithBase64EncodedString:self];
}

- (NSData *)base64ImageDecoded {
    /**
     data:,文本数据
     data:text/plain,文本数据
     data:text/html,HTML代码
     data:text/html;base64,base64编码的HTML代码
     data:text/css,CSS代码
     data:text/css;base64,base64编码的CSS代码
     data:text/javascript,Javascript代码
     data:text/javascript;base64,base64编码的Javascript代码
     data:image/gif;base64,base64编码的gif图片数据
     data:image/png;base64,base64编码的png图片数据
     data:image/jpeg;base64,base64编码的jpeg图片数据
     data:image/x-icon;base64,base64编码的icon图片数据
     */
    
    NSString *base64Str = [self stringByReplacingOccurrencesOfString:@"data:image/png;base64," withString:@""];
    base64Str = [base64Str stringByReplacingOccurrencesOfString:@"data:image/jpg;base64," withString:@""];
    base64Str = [base64Str stringByReplacingOccurrencesOfString:@"data:image/jpeg;base64," withString:@""];
    base64Str = [base64Str stringByReplacingOccurrencesOfString:@"data:image/gif;base64," withString:@""];
    base64Str = [base64Str stringByReplacingOccurrencesOfString:@"data:image/x-icon;base64," withString:@""];

    NSData *resData = [NSData dataWithBase64EncodedString:base64Str];
    return resData;
}

@end
