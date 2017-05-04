//
//  JavaScriptObject.h
//  iOSWithJsInteraction
//
//  Created by vstyle on 16/6/15.
//  Copyright © 2016年 cn.vstyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@import JavaScriptCore;
@protocol JavaScriptObjectExport <JSExport>
- (NSString *)get_app_version;
- (NSString *)db_insert:(NSString *)name :(NSString *)value; // 插入数据

@end

@interface JavaScriptObject : NSObject <JavaScriptObjectExport>

@end
