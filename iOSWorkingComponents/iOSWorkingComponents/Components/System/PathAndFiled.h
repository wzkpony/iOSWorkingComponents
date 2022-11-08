//
//  PathAndFiled.h
//  PodProduct
//
//  Created by wzk on 2018/3/9.
//  Copyright © 2018年 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathAndFiled : NSObject

+(void)getDBForPathCopy:(NSString*)name;

+(NSString *)loadPathWithName:(NSString *)filename;

+(NSArray* )loadFileForArrayWithPath:(NSString*)path;

/*
 * 创建文件夹,根目录是 Document
 * name：文件夹名字或者是路径+名字
 * 此方法会检测本地时候有文件，如果有，则不会创建，如果没有才会创建
 */

+(void)creatFolderWithName:(NSString *)name;
/*
 移动文件文件
 */
+(void)moveFileWithPaht:(NSString *)path toPath:(NSString*)toPath;

/*
 清除文件或者文件夹
*/
+(void)deleteFolderAndFolderWithPaht:(NSString *)name;

/*
 创建文件，如果有文件存在，怎不用创建，如果没有则需要创建
 */
+(void)creatFileWithName:(NSString* )name WithData:(id)data;

/*
 据文件名称，筛选文件，返回符合条件的文件名称列表
 path: 文件夹目录。format：少选格式：例如：SELF CONTAINS
 */
+(NSMutableArray* )selectFileWithPath:(NSString* )path withFormat:(NSString *)format;

/*
 读文件内容
 path： 文件路径。
 resultClass：文件返回对象
 */
+(id)readFileWithPath:(NSString *)path resultClass:(id)resultClass;

/*
 写入文件，将内容写入文件
 string： 文件内容
 path： 文件路径
 */
+(void)writeToFileContent:(id)content WithPaht:(NSString* )path;
@end
