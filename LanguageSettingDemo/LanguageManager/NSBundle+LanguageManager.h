//
//  NSBundle+LanguageManager.h
//  LanguageSettingDemo
//
//  Created by 沈宸 on 5/15/19.
//  Copyright © 2019 Calvin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (LanguageManager)

/**
 返回app当前设置的语言

 @return 当前语言
 */
+ (NSString *)currentLanguage;
@end

NS_ASSUME_NONNULL_END
