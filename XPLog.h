//
//  XPLog.h
//  TestCocoaPods
//
//  Created by lixiaopo on 16/6/29.
//  Copyright © 2016年 xiaopo li. All rights reserved.
//

#import <Foundation/Foundation.h>

extern int g_logLevel;

typedef enum eLogType
{
    LT_Fatal        = 0,    // 严重级别
    LT_Error        = 1,    // 错误级别
    LT_Warning      = 2,    // 警告级别
    LT_Information  = 3,    // 信息级别
    
    LT_Undefined            // 未定义级别
}LogType;

#define LOGF(fmt, ...) if (g_logLevel >= LT_Fatal) {\
    NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
    NSLog((@"%@ - [FAITAL] [%@:%d] : " fmt), [file lastPathComponent], \
    NSStringFromSelector(_cmd), __LINE__, ##__VA_ARGS__); \
}

#define LOGE(fmt, ...) if (g_logLevel >= LT_Error) {\
    NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
    NSLog((@"%@ - [ERROR] [%@:%d] : " fmt), [file lastPathComponent], \
    NSStringFromSelector(_cmd), __LINE__, ##__VA_ARGS__); \
}

#define LOGW(fmt, ...) if (g_logLevel >= LT_Warning) {\
        NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
    NSLog((@"%@ - [WARNING] [%@:%d] : " fmt), [file lastPathComponent], \
    NSStringFromSelector(_cmd), __LINE__, ##__VA_ARGS__); \
}

#define LOGI(fmt, ...) if (g_logLevel >= LT_Information) {\
    NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
    NSLog((@"%@ - [INFO] [%@:%d] : " fmt), [file lastPathComponent], \
    NSStringFromSelector(_cmd), __LINE__, ##__VA_ARGS__); \
}

@interface XPLog : NSObject
// 重定向日志到文件
+ (void)logSwitchFile;

// 获取log日志
+ (NSString *)getLogFile;

@end
