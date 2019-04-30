//
//  LanguageManager.m
//  libscutils
//
//  Created by 沈宸 on 4/29/19.
//  Copyright © 2019 沈宸. All rights reserved.
//

#import "LanguageManager.h"

#define LANGUAGE_KEY @"APPLanguageKey"

@interface LanguageManager ()

@property (strong, nonatomic) NSBundle *currentLanguageBundle; // 当前使用的语言集合包

@end

@implementation LanguageManager
+ (instancetype)sharedInstance
{
    static LanguageManager *manager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      manager = [[LanguageManager alloc] init];
    });

    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.supportLanguages = @[ @"zh-Hans", @"en" ];
        // 初始化当前支持的语言
        [self p_initLanguage];
    }
    return self;
}

- (void)setSupportLanguages:(NSArray< NSString * > *)supportLanguages
{
    _supportLanguages = supportLanguages;
    [self p_initLanguage];
}

- (void)setCurrentLanguge:(NSString *)currentLanguge
{
    // 如果与当前的相同，则跳过
    if ([_currentLanguge isEqualToString:currentLanguge])
    {
        return;
    }
    // 检查当前语言是否被app支持
    __block BOOL isExist = NO;
    [self.supportLanguages enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
      if ([currentLanguge isEqualToString:obj])
      {
          isExist = YES;
          *stop   = YES;
      }
    }];
    if (isExist)
    {
        _currentLanguge        = currentLanguge;
        _currentLanguageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:_currentLanguge ofType:@"lproj"]];
        [[NSUserDefaults standardUserDefaults] setObject:_currentLanguge forKey:LANGUAGE_KEY];
        // 设置这一句可以让storyboard和图片等资源本地化
        [[NSUserDefaults standardUserDefaults] setObject:@[_currentLanguge] forKey:@"AppleLanguages"];
    }
    if (_languageChangeBlock)
        _languageChangeBlock();
}

// 初始化当前支持的语言
- (void)p_initLanguage
{
    // 获取app当前设置的Language
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_KEY];
    if (language)
    {
        self.currentLanguge = language;
    }
    else
    {
        // 如果没有采用系统语言
        NSString *systemLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"][0];
        [self.supportLanguages enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
          // 查看当前系统语言是否被app支持
          if ([obj isEqualToString:systemLanguage])
          {
              self.currentLanguge = systemLanguage;
              *stop               = YES;
          }
        }];
        // 如果系统语言不被支持，默认采用首选语言
        if (!_currentLanguge)
            self.currentLanguge = self.supportLanguages[0];
    }
}

- (NSString *)localizedStringForKey:(NSString *)key table:(NSString *)tableName
{
    if(_currentLanguageBundle)
        return NSLocalizedStringFromTableInBundle(key, tableName, _currentLanguageBundle, nil);
    else
        return NSLocalizedStringFromTable(key, tableName, nil);
}

@end
