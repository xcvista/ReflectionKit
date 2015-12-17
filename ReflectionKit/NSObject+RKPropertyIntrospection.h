//
//  NSObject+RKPropertyIntrospection.h
//  ReflectionKit
//
//  Created by Maxthon Chan on 12/17/15.
//  Copyright © 2015 DreamCity. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RKPropertyIntrospection)

+ (NSArray<NSString *> *)allKeys;
@property (readonly) NSArray<NSString *> *allKeys;

+ (nullable Class)classForKey:(NSString *)key;
- (nullable Class)classForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
