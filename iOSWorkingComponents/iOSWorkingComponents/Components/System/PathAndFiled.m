//
//  PathAndFiled.m
//  PodProduct
//
//  Created by wzk on 2018/3/9.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import "PathAndFiled.h"

@implementation PathAndFiled
#pragma mark -- 文件管理
+(void)getDBForPathCopy:(NSString*)name
{
    NSArray* array = [name componentsSeparatedByString:@"."];
    if ([array count]<2) {
        return;
    }
    NSString* stringDB = [[NSBundle mainBundle]pathForResource:[array objectAtIndex:0] ofType:[array objectAtIndex:1]];
    if (stringDB == nil) {
        return;
    }
    NSString* stringpath = [self getSandBoxPathWithName:name];
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:stringpath]) {
        if ( [manager copyItemAtPath:stringDB toPath:stringpath error:Nil]) {
            NSLog(@"数据库拷贝成功");
        }
        else
        {
            NSLog(@"数据库拷贝失败");
        }
    }
    else
    {
        NSLog(@"数据库已经存在");
    }
    
}

+(NSString *)loadPathWithName:(NSString *)filename
{
    NSFileManager *fileMang = [NSFileManager defaultManager];
    
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *rePath = [documentDir stringByAppendingPathComponent:filename];
    
    BOOL dbIsExits = [fileMang fileExistsAtPath:rePath];
    if (!dbIsExits) {
        NSArray* array = [filename componentsSeparatedByString:@"."];
        
        if ([array count]==2) {//当文件有一个.的时候
            rePath = [[NSBundle mainBundle] pathForResource:[array objectAtIndex:0] ofType:[array objectAtIndex:1]];
        }
        if ([array count]==3) {//当文件有两个.的时候
            rePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.%@",[array objectAtIndex:0],[array objectAtIndex:1]] ofType:[array objectAtIndex:2]];
        }
        BOOL dbIsExitss = [fileMang fileExistsAtPath:rePath];
        if (!dbIsExitss) {
            rePath = @"no path";
        }
    }
    return  rePath;
}

+(NSArray* )loadFileForArrayWithPath:(NSString*)path
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray* arrays = nil;
    if ([fileManager fileExistsAtPath:path] != NO) {
        arrays = [fileManager contentsOfDirectoryAtPath:path error:nil];
    }
    
    return arrays;
}
#pragma mark -- private start--
+(NSString *)getSandBoxPathWithName:(NSString*)name
{
    return [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",name]];;
}

+(NSString *)getPathForDocument
{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return path ;
}
#pragma mark -- private end--
+(void)creatFolderWithName:(NSString *)name
{
    NSError* error = nil;
    NSString* nameString = [NSString stringWithFormat:@"%@",name];
    NSString* path = [[self getPathForDocument] stringByAppendingPathComponent:nameString];
    
    NSFileManager* file = [NSFileManager defaultManager];
    if (![file fileExistsAtPath:path]) {
        [file createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
}

+(void)moveFileWithPaht:(NSString *)path toPath:(NSString*)toPath
{
    NSError* error = nil;
    NSFileManager* file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:path]==YES) {
        [file moveItemAtPath:path toPath:toPath error:&error];
    }
    
}
+(void)deleteFolderAndFolderWithPaht:(NSString *)path
{
    NSError* error = nil;
    NSFileManager* file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:path]!=NO) {
        [file removeItemAtPath:path error:&error];
    }
    
}

+(void)creatFileWithName:(NSString* )name WithData:(id)data
{
    NSFileManager* file = [NSFileManager defaultManager];
    if (![file fileExistsAtPath:[[self getPathForDocument]stringByAppendingPathComponent:name]]) {
        [data writeToFile:[[self getPathForDocument] stringByAppendingPathComponent:name] atomically:YES];
    }
    else
    {
        NSLog(@"文件已经存在");
    }
}

+(NSMutableArray* )selectFileWithPath:(NSString* )path withFormat:(NSString *)format//根据文件名称，筛选文件，返回符合条件的文件名称列表
{
    NSFileManager *fileManage=[NSFileManager defaultManager];
    
    NSArray *fileArray = [fileManage contentsOfDirectoryAtPath:path error:nil];//列出目录内容
    //@"SELF CONTAINS %@",type
    NSMutableArray* arraymutable = [[NSMutableArray alloc] initWithCapacity:0];
    NSPredicate *pre=[NSPredicate predicateWithFormat:format];
    
    fileArray = [fileArray filteredArrayUsingPredicate:pre];
    for (NSString *name in fileArray) {
        [arraymutable addObject:name];
        
    }
    return arraymutable;
}

+(id)readFileWithPath:(NSString *)path resultClass:(id)resultClass
{
    NSFileManager* file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:path]) {
        if ([resultClass isKindOfClass:[NSArray class]]) {
            resultClass = [NSArray arrayWithContentsOfFile:path];
        }
        if ([resultClass isKindOfClass:[NSString class]]) {
            resultClass = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        }
        if ([resultClass isKindOfClass:[NSDictionary class]]) {
            resultClass = [NSDictionary dictionaryWithContentsOfFile:path];
        }
        if ([resultClass isKindOfClass:[NSData class]]) {
            resultClass = [NSData dataWithContentsOfFile:path];
        }
    }
    return resultClass;
}

+(void)writeToFileContent:(id)content WithPaht:(NSString* )path
{
    NSFileManager* file = [NSFileManager defaultManager];
    
    if ([file fileExistsAtPath:path]) {
        
        NSFileHandle* handle = [NSFileHandle fileHandleForWritingAtPath:path];
        
        [handle seekToEndOfFile];
        
        NSData* buffer =  content;
        if ([content isKindOfClass:[NSString class]]) {
           buffer = [content dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        [handle writeData:buffer];
        
        [handle closeFile];
    }
    
}

@end
