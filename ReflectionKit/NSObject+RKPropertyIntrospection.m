//
//  NSObject+RKPropertyIntrospection.m
//  ReflectionKit
//
//  Created by Maxthon Chan on 12/17/15.
//  Copyright © 2015 DreamCity. All rights reserved.
//

#import "NSObject+RKPropertyIntrospection.h"
#import <objc/runtime.h>

@implementation NSObject (RKPropertyIntrospection)

+ (NSArray<NSString *> *)allKeys
{
    unsigned property_count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &property_count);
    NSMutableArray<NSString *> *allKeys = [NSMutableArray<NSString *> arrayWithCapacity:property_count];
    
    for (unsigned idx = 0; idx < property_count; idx++)
    {
        objc_property_t property = properties[idx];
        char *readonly = property_copyAttributeValue(property, "R");
        if (!readonly)
            [allKeys addObject:@(property_getName(property))];
        else
            free(readonly);
    }
    
    free(properties);
    return allKeys;
}

- (NSArray<NSString *> *)allKeys
{
    return [self.class allKeys];
}

+ (Class)classForKey:(NSString *)key
{
    objc_property_t property = class_getProperty(self, key.UTF8String);
    if (!property)
        return Nil;
    
    char *_type = property_copyAttributeValue(property, "T");
    NSString NS_VALID_UNTIL_END_OF_SCOPE *type = [[NSString alloc] initWithBytesNoCopy:_type length:strlen(_type) encoding:NSUTF8StringEncoding freeWhenDone:YES];
    
    if (strchr("cislqCISLQfdB", *_type))
        return [NSNumber class];
    else if (*_type == '@')
    {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^@\\\"(.*)\\\"$" options:NSRegularExpressionAnchorsMatchLines error:NULL];
        NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:type options:0 range:NSMakeRange(0, type.length)];
        
        if (matches.count < 1)
            return [NSObject class];
        else
        {
            NSString *name = [regex stringByReplacingMatchesInString:type options:0 range:NSMakeRange(0, type.length) withTemplate:@"$1"];
            Class class = NSClassFromString(name) ?: [NSObject class];
            return class;
        }
    }
    else
        return [NSValue class];
    
    return Nil;
}

- (Class)classForKey:(NSString *)key
{
    return [self.class classForKey:key];
}

@end
