//
//  JavaScriptObject.m
//  iOSWithJsInteraction
//
//  Created by vstyle on 16/6/15.
//  Copyright © 2016年 cn.vstyle. All rights reserved.
//

#import "JavaScriptObject.h"

@implementation JavaScriptObject
- (NSString *)get_app_version{
    NSLog(@"获取软件版本号");
    NSString *bundleStr = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *returnBundleStr = [NSString stringWithFormat:@"iOS_%@",bundleStr];
    return returnBundleStr;
}

- (NSString *)db_insert:(NSString *)name :(NSString *)value{
    NSLog(@"\n插入数据名称---%@\n插入数据    ---%@",name,value);
    NSDictionary *dict = @{name:value};
    return [self toJsonWithDict:dict];
}


- (NSString *)toJsonWithDict:(NSDictionary *)dict {
    NSError *error;
    NSData *datas = [NSJSONSerialization dataWithJSONObject:dict
                                                    options:NSJSONWritingPrettyPrinted
                                                      error:&error];
    return [[NSString alloc] initWithData:datas encoding:NSUTF8StringEncoding];
}
@end
