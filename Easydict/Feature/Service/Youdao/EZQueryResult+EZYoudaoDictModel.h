//
//  EZQueryResult+EZYoudaoDictModel.h
//  Easydict
//
//  Created by tisfeng on 2022/12/31.
//  Copyright © 2022 izual. All rights reserved.
//

#import "EZQueryResult.h"
#import "EZYoudaoDictModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EZQueryResult (EZYoudaoDictModel)

+ (instancetype)resultWithYoudaoDictModel:(EZYoudaoDictModel *)model;

- (instancetype)setupWithYoudaoDictModel:(EZYoudaoDictModel *)model;

@end

NS_ASSUME_NONNULL_END
