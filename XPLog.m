//
//  XPLog.m
//  TestCocoaPods
//
//  Created by lixiaopo on 16/6/29.
//  Copyright © 2016年 xiaopo li. All rights reserved.
//

#import "XPLog.h"

// 最大单个日志文件大小, 目前暂时定为5M
#define kMaxLogFileSize (1024 * 5 * 1024)
// 设置默认日志级别
int g_logLevel = LT_Information;

///
static NSString *_logFileName = @"";
static NSString *_filePath  = @"";

@implementation XPLog
// 重定向日志到文件
+ (void)logSwitchFile
{
    [self getLogFile];
    
    // 保存文件备份日志名称
    NSString *logbakPath = [_filePath stringByAppendingPathComponent:@"log_bak.txt"];
    
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:_logFileName]) {
        BOOL needBakLogFile = NO;
        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:_logFileName error:&error];
        if(fileAttributes != nil) {
            NSNumber *fileSize = [fileAttributes objectForKey:NSFileSize];
            needBakLogFile = ([fileSize unsignedLongLongValue] > kMaxLogFileSize);
        }// if
        
        if (needBakLogFile) {
            // 删除旧的备份文件
            [fileManager removeItemAtPath:logbakPath error:&error];
            // 修改文件名称
            [fileManager moveItemAtPath:_logFileName toPath:logbakPath error:&error];
        }// if
    }// if
    
    FILE *newerr = fopen([_logFileName cStringUsingEncoding:NSASCIIStringEncoding], "a+");
    if (newerr) {
        dup2(fileno(newerr), STDERR_FILENO);
        fclose(newerr);
    }
}

// 获取log日志
+ (NSString *)getLogFile
{
    if (0 == [_logFileName length]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *libraryPath = [paths objectAtIndex:0];
        _filePath = [libraryPath stringByAppendingPathComponent:@"Log/"];
        
        BOOL isDirectory = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // 路径不存在就创建
        if (!([fileManager fileExistsAtPath:_filePath isDirectory:&isDirectory] &&
              isDirectory)) {
            [fileManager createDirectoryAtPath:_filePath
                   withIntermediateDirectories:YES
                                    attributes:nil error:nil];
        }
        
        // 保存日志的名称
        _logFileName = [_filePath stringByAppendingPathComponent:@"log.txt"];
    }
    return _logFileName;
}

@end
