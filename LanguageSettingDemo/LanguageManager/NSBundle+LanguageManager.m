//
//  NSBundle+LanguageManager.m
//  LanguageSettingDemo
//
//  Created by 沈宸 on 5/15/19.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import "NSBundle+LanguageManager.h"
#import <objc/runtime.h>
#import "LanguageManager.h"

@interface SCBundle : NSBundle

@end

@implementation SCBundle
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    if ([SCBundle sc_mainBundle])
    {
        return [[SCBundle sc_mainBundle] localizedStringForKey:key value:value table:tableName];
    }
    else
    {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

+ (NSBundle *)sc_mainBundle
{
    if ([NSBundle currentLanguage].length)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSBundle currentLanguage] ofType:@"lproj"];
        if (path.length)
        {
            return [NSBundle bundleWithPath:path];
        }
    }
    return nil;
}
@end

@implementation NSBundle (LanguageManager)
+ (void)load
{
    //动态继承、交换，方法类似KVO，通过修改[NSBundle mainBundle]对象的isa指针，使其指向它的子类DABundle，这样便可以调用子类的方法；其实这里也可以使用method_swizzling来交换mainBundle的实现，来动态判断，可以同样实现。
    object_setClass([NSBundle mainBundle], [SCBundle class]);
}

+ (NSString *)currentLanguage
{
    return [LanguageManager sharedInstance].currentLanguge;
}
@end

