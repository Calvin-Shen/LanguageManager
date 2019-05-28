# LanguageManager
ios本地化

项目中用的话直接将 LanguageManager文件夹 拖入到工程中 
### 设置App支持的语言 e.g.
```
[[LanguageManager sharedInstance] setSupportLanguages:@[@"zh-Hans",@"zh-Hant",@"en"]];
```

### 设置当前语言 e.g.
```
[[LanguageManager sharedInstance] setCurrentLanguge:@"en"];
```

### 调用宏来实现本地化 e.g.
```
cell.textLabel.text = LanguageString(@"en", @"LanguageSettingTableVC");
```

### 注意:xib或者storyboard文件的本地化可以直接写在string文件中，不需要调用LanguageString(aaaa,bbbb)这样的宏去定义，宏只用于代码中的文字本地化。

具体参考demo
