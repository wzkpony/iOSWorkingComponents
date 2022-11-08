//
//  UIDevice+Hardware.m
//  NewCode
//
//  Created by 王正魁 on 14-4-29.
//  Copyright (c) 2014年 psylife. All rights reserved.
//

#import "UIDevice+Hardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>
@implementation UIDevice (Hardware)
+(NSString*)getSysInfoVyName:(char*)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char* answer = malloc(size);
    NSString* results = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
    free(answer);
    return results;
}
+(NSString* )platform
{
    NSLog(@"%@",[UIDevice getSysInfoVyName:"hw.machine"]);
    return[UIDevice getSysInfoVyName:"hw.machine"];
}
+(NSUInteger)getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW,typeSpecifier};
    sysctl(mib,2,&results,&size,NULL,0);
    return(NSUInteger)results;
}
+(NSUInteger)cpuFrequecy
{
    return [UIDevice getSysInfo:HW_CPU_FREQ];
}
+(NSInteger)busFrequency
{
    return [UIDevice getSysInfo:HW_BUS_FREQ];
}
+(NSUInteger)totalMemory
{
    return [UIDevice getSysInfo:HW_PHYSMEM];
}
+(NSUInteger)userMemory
{
    return [UIDevice getSysInfo:HW_USERMEM];
}
+(NSUInteger)maxSocketBufferSize
{
    return [UIDevice getSysInfo:KIPC_MAXSOCKBUF];
}

#pragma mark -- UIDevice信息 --
+(NSString* )get_Model
{
    UIDevice* device = [UIDevice currentDevice];
    return device.model;
}
+(NSString* )get_SystemVersion
{
    UIDevice* device = [UIDevice currentDevice];
    return device.systemVersion;
}

+(NSString* )get_SystemName
{
    UIDevice* device = [UIDevice currentDevice];
    return device.systemName;
}
+(NSString* )get_DeviceName
{
    UIDevice* device = [UIDevice currentDevice];
    return device.name;
}

+(NSString* )get_Verion
{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return version;
}
+(NSString* )get_BundleDisplayName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return name;
}
/*
//获取设备👌
+ (NSString *)getDeviceId:(NSString *)kKeychainService kKeychainDeviceId:(NSString *)kKeychainDeviceId {
    // 读取设备号
    NSString *localDeviceId = [SAMKeychain passwordForService:kKeychainService account:kKeychainDeviceId];
    if (!localDeviceId) {
        // 保存设备号
        CFUUIDRef deviceId = CFUUIDCreate(NULL);
        assert(deviceId != NULL);
        CFStringRef deviceIdStr = CFUUIDCreateString(NULL, deviceId);
        [SAMKeychain setPassword:[NSString stringWithFormat:@"%@", deviceIdStr] forService:kKeychainService account:kKeychainDeviceId];
        localDeviceId = [NSString stringWithFormat:@"%@", deviceIdStr];
    }
    return localDeviceId;
}
*/
@end
