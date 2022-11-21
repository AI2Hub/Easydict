//
//  EZQueryModel.h
//  Open Bob
//
//  Created by tisfeng on 2022/11/21.
//  Copyright © 2022 izual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslateLanguage.h"

NS_ASSUME_NONNULL_BEGIN

@interface EZQueryModel : NSObject

@property (nonatomic, copy) NSString *queryText;
//@property (nonatomic, copy) NSString *detectLanguage;
@property (nonatomic, assign) Language fromLanguage;
@property (nonatomic, assign) Language toLanguage;


@property (nonatomic, assign) CGFloat viewHeight;

@end

NS_ASSUME_NONNULL_END
