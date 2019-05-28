//
//  LanguageManager.h
//  libscutils
//
//  Created by 沈宸 on 4/29/19.
//  Copyright © 2019 沈宸. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define LanguageString(key, tableName) [[LanguageManager sharedInstance] localizedStringForKey:key table:tableName]

typedef void (^LanguageChangeBlock)(void);

@interface LanguageManager : NSObject

/**
 创建一个语言管理类的单例
 */
+ (instancetype)sharedInstance;


/**
 还原成系统语言
 */
+ (void)resetSystemLanguage;

/**
 设置app支持的语言,默认支持zh-Hans,en
 */
@property (strong, nonatomic) NSArray< NSString * > *supportLanguages;

/**
 当前app的语言,默认为zh-Hans
 */
@property (strong, nonatomic) NSString *currentLanguge;

/**
 改变app当前语言执行的回调，可用于回调界面，默认为nil
 */
@property (copy, nonatomic) LanguageChangeBlock languageChangeBlock;

/**
 从指定string文件中获取指定key的本地化语言

 @param key 指定key
 @param tableName 文件名称
 @return 本体化的解释
 */
- (NSString *)localizedStringForKey:(NSString *)key table:(NSString *)tableName;

@end

NS_ASSUME_NONNULL_END
