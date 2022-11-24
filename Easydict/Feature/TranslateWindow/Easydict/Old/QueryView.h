//
//  QueryView.h
//  Bob
//
//  Created by ripper on 2019/11/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN


@interface QueryView : NSView

DefineMethodMMMake_h(QueryView, view);

@property (nonatomic, strong) NSTextView *textView;

@property (nonatomic, copy) NSString *queryText;
@property (nonatomic, copy) NSString *detectLanguage;

@property (nonatomic, copy) void (^audioActionBlock)(QueryView *view);
@property (nonatomic, copy) void (^copyActionBlock)(QueryView *view);
@property (nonatomic, copy) void (^enterActionBlock)(QueryView *view);

@end

NS_ASSUME_NONNULL_END
