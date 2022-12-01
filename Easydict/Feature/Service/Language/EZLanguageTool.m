//
//  EZLanguage.m
//  Easydict
//
//  Created by tisfeng on 2022/11/30.
//  Copyright © 2022 izual. All rights reserved.
//

#import "EZLanguageTool.h"
#import "EZAppleService.h"

NSString *const EZLanguageAuto = @"auto";
NSString *const EZLanguageSimplifiedChinese = @"Chinese-Simplified";
NSString *const EZLanguageTraditionalChinese = @"Chinese-Traditional";
NSString *const EZLanguageEnglish = @"English";
NSString *const EZLanguageJapanese = @"Japanese";
NSString *const EZLanguageKorean = @"Korean";
NSString *const EZLanguageFrench = @"French";
NSString *const EZLanguageSpanish = @"Spanish";
NSString *const EZLanguagePortuguese = @"Portuguese";
NSString *const EZLanguageItalian = @"Italian";
NSString *const EZLanguageGerman = @"German";
NSString *const EZLanguageRussian = @"Russian";
NSString *const EZLanguageArabic = @"Arabic";
NSString *const EZLanguageSwedish = @"Swedish";
NSString *const EZLanguageRomanian = @"Romanian";
NSString *const EZLanguageThai = @"Thai";
NSString *const EZLanguageSlovak = @"Slovak";
NSString *const EZLanguageDutch = @"Dutch";
NSString *const EZLanguageHungarian = @"Hungarian";
NSString *const EZLanguageGreek = @"Greek";
NSString *const EZLanguageDanish = @"Danish";
NSString *const EZLanguageFinnish = @"Finnish";
NSString *const EZLanguagePolish = @"Polish";
NSString *const EZLanguageCzech = @"Czech";
NSString *const EZLanguageTurkish = @"Turkish";
NSString *const EZLanguageLithuanian = @"Lithuanian";
NSString *const EZLanguageLatvian = @"Latvian";
NSString *const EZLanguageUkrainian = @"Ukrainian";
NSString *const EZLanguageBulgarian = @"Bulgarian";
NSString *const EZLanguageIndonesian = @"Indonesian";
NSString *const EZLanguageMalay = @"Malay";
NSString *const EZLanguageSlovenian = @"Slovenian";
NSString *const EZLanguageEstonian = @"Estonian";
NSString *const EZLanguageVietnamese = @"Vietnamese";
NSString *const EZLanguagePersian = @"Persian";
NSString *const EZLanguageHindi = @"Hindi";
NSString *const EZLanguageTelugu = @"Telugu";
NSString *const EZLanguageTamil = @"Tamil";
NSString *const EZLanguageUrdu = @"Urdu";
NSString *const EZLanguageFilipino = @"Filipino";
NSString *const EZLanguageKhmer = @"Khmer";
NSString *const EZLanguageLao = @"Lao";
NSString *const EZLanguageBengali = @"Bengali";
NSString *const EZLanguageNorwegian = @"Norwegian";
NSString *const EZLanguageSerbian = @"Serbian";
NSString *const EZLanguageCroatian = @"Croatian";
NSString *const EZLanguageMongolian = @"Mongolian";
NSString *const EZLanguageHebrew = @"Hebrew";


@implementation EZLanguageTool

// Get target language with source language
+ (EZLanguage)targetLanguageWithSourceLanguage:(EZLanguage)sourceLanguage {
    EZLanguage firstLanguage = [self firstLanguage];
    EZLanguage secondLanguage = [self secondLanguage];
    EZLanguage targetLanguage = firstLanguage;
    if ([sourceLanguage isEqualToString:firstLanguage]) {
        targetLanguage = secondLanguage;
    }
    return targetLanguage;
}

// Get user system preferred languages
+ (NSArray<EZLanguage> *)systemPreferredLanguages {
    // ["zh-Hans-CN", "en-CN"]
    NSArray<NSString *> *preferredLanguages = [NSLocale preferredLanguages];
    NSMutableArray *languages = [NSMutableArray array];
    for (NSString *language in preferredLanguages) {
        // "zh-Hans-CN" -> "zh-Hans"
        NSMutableArray *array = [[language componentsSeparatedByString:@"-"] mutableCopy];
        // Remove country code
        [array removeLastObject];
        NSString *languageCode = [array componentsJoinedByString:@"-"];
        // Convert to EZLanguage
        EZAppleService *appleService = [[EZAppleService alloc] init];
        EZLanguage ezLanguage = [appleService languageEnumFromString:languageCode];

        [languages addObject:ezLanguage];
    }

    // This method seems to be the same.
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSArray *userLanguages = [defaults objectForKey:@"AppleLanguages"];

//    NSLog(@"languages: %@", languages);

    return languages;
}

+ (NSArray<EZLanguage> *)preferredTwoLanguages {
    NSMutableArray *twoLanguages = [NSMutableArray array];
    NSArray<EZLanguage> *languages = [self systemPreferredLanguages];

    EZLanguage firstLanguage = languages.firstObject;
    [twoLanguages addObject:firstLanguage];

    if (languages.count > 1) {
        [twoLanguages addObject:languages[1]];
    } else {
        EZLanguage secondLanguage = EZLanguageEnglish;
        if ([firstLanguage isEqualToString:EZLanguageEnglish]) {
            secondLanguage = EZLanguageSimplifiedChinese;
        }
        [twoLanguages addObject:secondLanguage];
    }

    return twoLanguages;
}

+ (BOOL)containsEnglishInPreferredTwoLanguages {
    NSArray<EZLanguage> *languages = [self preferredTwoLanguages];
    return [languages containsObject:EZLanguageEnglish];
}

+ (BOOL)containsChineseInPreferredTwoLanguages {
    NSArray<EZLanguage> *languages = [self preferredTwoLanguages];
    for (EZLanguage language in languages) {
        if ([self isChineseLanguage:language]) {
            return YES;
        }
    }
    return NO;
}


+ (EZLanguage)firstLanguage {
    return [self preferredTwoLanguages][0];
}
+ (EZLanguage)secondLanguage {
    return [self preferredTwoLanguages][1];
}

+ (BOOL)isChineseFirstLanguage {
    EZLanguage firstLanguage = [self firstLanguage];
    return [self isChineseLanguage:firstLanguage];
}

+ (BOOL)isChineseLanguage:(EZLanguage)language {
    if (language == EZLanguageSimplifiedChinese || language == EZLanguageTraditionalChinese) {
        return YES;
    }
    return NO;
}

+ (BOOL)containsEnglishPreferredLanguage {
    NSArray<EZLanguage> *languages = [self systemPreferredLanguages];
    for (EZLanguage language in languages) {
        if (language == EZLanguageEnglish) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)containsChinesePreferredLanguage {
    NSArray<EZLanguage> *languages = [self systemPreferredLanguages];
    for (EZLanguage language in languages) {
        if (language == EZLanguageEnglish) {
            return YES;
        }
    }
    return NO;
}


/// Showing language name according user first language, Chinese: English -> 英语, English: English -> English.
+ (NSString *)showingLanguageName:(EZLanguage)language {
    NSString *languageName = language;
    if ([self isChineseFirstLanguage]) {
        languageName = [self languageChineseName:language];
    }
    return languageName;
}


// Get language Chinese name, such as "简体中文"
+ (NSString *)languageChineseName:(EZLanguage)language {
    static NSDictionary *languageNameDict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        languageNameDict = @{
            EZLanguageAuto : @"自动检测",
            EZLanguageSimplifiedChinese : @"简体中文",
            EZLanguageTraditionalChinese : @"繁体中文",
            EZLanguageEnglish : @"英语",
            EZLanguageJapanese : @"日语",
            EZLanguageKorean : @"韩语",
            EZLanguageFrench : @"法语",
            EZLanguageSpanish : @"西班牙语",
            EZLanguagePortuguese : @"葡萄牙语",
            EZLanguageItalian : @"意大利语",
            EZLanguageGerman : @"德语",
            EZLanguageRussian : @"俄语",
            EZLanguageArabic : @"阿拉伯语",
            EZLanguageSwedish : @"瑞典语",
            EZLanguageRomanian : @"罗马尼亚语",
            EZLanguageThai : @"泰语",
            EZLanguageSlovak : @"斯洛伐克语",
            EZLanguageDutch : @"荷兰语",
            EZLanguageHungarian : @"匈牙利语",
            EZLanguageGreek : @"希腊语",
            EZLanguageDanish : @"丹麦语",
            EZLanguageFinnish : @"芬兰语",
            EZLanguagePolish : @"波兰语",
            EZLanguageCzech : @"捷克语",
            EZLanguageTurkish : @"土耳其语",
            EZLanguageLithuanian : @"立陶宛语",
            EZLanguageLatvian : @"拉脱维亚语",
            EZLanguageUkrainian : @"乌克兰语",
            EZLanguageBulgarian : @"保加利亚语",
            EZLanguageIndonesian : @"印尼语",
            EZLanguageMalay : @"马来语",
            EZLanguageSlovenian : @"斯洛文尼亚语",
            EZLanguageEstonian : @"爱沙尼亚语",
            EZLanguageVietnamese : @"越南语",
            EZLanguagePersian : @"波斯语",
            EZLanguageHindi : @"印地语",
            EZLanguageTelugu : @"泰卢固语",
            EZLanguageTamil : @"泰米尔语",
            EZLanguageUrdu : @"乌尔都语",
            EZLanguageFilipino : @"菲律宾语",
            EZLanguageKhmer : @"高棉语",
            EZLanguageLao : @"老挝语",
            EZLanguageBengali : @"孟加拉语",
            EZLanguageNorwegian : @"挪威语",
            EZLanguageSerbian : @"塞尔维亚语",
            EZLanguageCroatian : @"克罗地亚语",
            EZLanguageMongolian : @"蒙古语",
            EZLanguageHebrew : @"希伯来语",
        };
    });

    return languageNameDict[language];
}

// Get language flag emoji according to language, such as "🇨🇳"
+ (NSString *)languageFlagEmoji:(EZLanguage)language {
    static NSDictionary *languageFlagEmojiDict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        languageFlagEmojiDict = @{
            EZLanguageAuto : @"🌐",
            EZLanguageSimplifiedChinese : @"🇨🇳",
            EZLanguageTraditionalChinese : @"🇭🇰",
            EZLanguageEnglish : @"🇬🇧",
            EZLanguageJapanese : @"🇯🇵",
            EZLanguageKorean : @"🇰🇷",
            EZLanguageFrench : @"🇫🇷",
            EZLanguageSpanish : @"🇪🇸",
            EZLanguagePortuguese : @"🇵🇹",
            EZLanguageItalian : @"🇮🇹",
            EZLanguageGerman : @"🇩🇪",
            EZLanguageRussian : @"🇷🇺",
            EZLanguageArabic : @"🇸🇦",
            EZLanguageSwedish : @"🇸🇪",
            EZLanguageRomanian : @"🇷🇴",
            EZLanguageThai : @"🇹🇭",
            EZLanguageSlovak : @"🇸🇰",
            EZLanguageDutch : @"🇳🇱",
            EZLanguageHungarian : @"🇭🇺",
            EZLanguageGreek : @"🇬🇷",
            EZLanguageDanish : @"🇩🇰",
            EZLanguageFinnish : @"🇫🇮",
            EZLanguagePolish : @"🇵🇱",
            EZLanguageCzech : @"🇨🇿",
            EZLanguageTurkish : @"🇹🇷",
            EZLanguageLithuanian : @"🇱🇹",
            EZLanguageLatvian : @"🇱🇻",
            EZLanguageUkrainian : @"🇺🇦",
            EZLanguageBulgarian : @"🇧🇬",
            EZLanguageIndonesian : @"🇮🇩",
            EZLanguageMalay : @"🇲🇾",
            EZLanguageSlovenian : @"🇸🇮",
            EZLanguageEstonian : @"🇪🇪",
            EZLanguageVietnamese : @"🇻🇳",
            EZLanguagePersian : @"🇮🇷",
            EZLanguageHindi : @"🇮🇳",
            EZLanguageTelugu : @"🇮🇳",
            EZLanguageTamil : @"🇮🇳",
            EZLanguageUrdu : @"🇵🇰",
            EZLanguageFilipino : @"🇵🇭",
            EZLanguageKhmer : @"🇰🇭",
            EZLanguageLao : @"🇱🇦",
            EZLanguageBengali : @"🇧🇩",
            EZLanguageNorwegian : @"🇳🇴",
            EZLanguageSerbian : @"🇷🇸",
            EZLanguageCroatian : @"🇭🇷",
            EZLanguageMongolian : @"🇲🇳",
            EZLanguageHebrew : @"🇮🇱",
        };
    });

    return languageFlagEmojiDict[language];
}


@end
