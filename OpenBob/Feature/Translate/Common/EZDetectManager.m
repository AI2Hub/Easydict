//
//  DetectText.m
//  Bob
//
//  Created by tisfeng on 2022/11/5.
//  Copyright © 2022 ripperhe. All rights reserved.
//

#import "EZDetectManager.h"
#import "BaiduTranslate.h"

@interface EZDetectManager ()

@property (nonatomic, strong) TranslateService *translate;

@end

@implementation EZDetectManager

- (instancetype)init {
    if (self = [super init]) {
        _translate = [[BaiduTranslate alloc] init];
    }
    return self;
}


- (void)detect:(NSString *)text completion:(nonnull void (^)(Language, NSError *_Nullable))completion {
    [self.translate detect:text completion:^(Language lang, NSError * _Nullable error) {
        self.language = lang;
        completion(lang, error);
    }];
}

@end
