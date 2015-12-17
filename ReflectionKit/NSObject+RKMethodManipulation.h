//
//  NSObject+RKMethodManipulation.h
//  ReflectionKit
//
//  Created by Maxthon Chan on 12/17/15.
//  Copyright © 2015 DreamCity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RKMethodManipulation)

+ (NSArray<NSString *> *)allSelectors;
@property (readonly) NSArray<NSString *> *allSelectors;

+ (void)swapInstanceMethodsOfSelector:(SEL)original withSelector:(SEL)replacement;
+ (void)swapClassMethodsOfSelector:(SEL)original withSelector:(SEL)replacement;

+ (IMP)replaceImplementationOfInstanceMethodWithSelector:(SEL)selector withImplementation:(IMP)other;
+ (IMP)replaceImplementationOfClassMethodWithSelector:(SEL)selector withImplementation:(IMP)other;

@end

NS_ASSUME_NONNULL_END
