//
//  NSObject+RKMethodManipulation.m
//  ReflectionKit
//
//  Created by Maxthon Chan on 12/17/15.
//  Copyright © 2015 DreamCity. All rights reserved.
//

#import "NSObject+RKMethodManipulation.h"
#import <objc/runtime.h>

@implementation NSObject (RKMethodManipulation)

+ (NSArray<NSString *> *)allSelectors
{
    unsigned method_count = 0;
    Method *methods = class_copyMethodList(self, &method_count);
    NSMutableArray<NSString *> *allSelectors = [NSMutableArray<NSString *> arrayWithCapacity:method_count];
    
    for (unsigned idx = 0; idx < method_count; idx++)
    {
        Method method = methods[idx];
        SEL selector = method_getName(method);
        
        [allSelectors addObject:NSStringFromSelector(selector)];
    }
    
    free(methods);
    return allSelectors;
}

- (NSArray<NSString *> *)allSelectors
{
    return [self.class allSelectors];
}

#pragma mark - Method swap

void _RKSwitchMethods(Class class, Method m1, Method m2)
{
    BOOL didAddMethod = class_addMethod(class, method_getName(m1), method_getImplementation(m2), method_getTypeEncoding(m2));
    
    if (didAddMethod)
    {
        class_replaceMethod(class, method_getName(m2), method_getImplementation(m1), method_getTypeEncoding(m1));
    }
    else
    {
        method_exchangeImplementations(m1, m2);
    }
}

+ (void)swapInstanceMethodsOfSelector:(SEL)original withSelector:(SEL)replacement
{
    _RKSwitchMethods(self, class_getInstanceMethod(self, original), class_getInstanceMethod(self, replacement));
}

+ (void)swapClassMethodsOfSelector:(SEL)original withSelector:(SEL)replacement
{
    _RKSwitchMethods(object_getClass((id)self), class_getClassMethod(self, original), class_getClassMethod(self, replacement));
}

#pragma mark - Implementation swap

+ (IMP)replaceImplementationOfInstanceMethodWithSelector:(SEL)selector withImplementation:(IMP)other
{
    Method m = class_getInstanceMethod(self, selector);
    return method_setImplementation(m, other);
}

+ (IMP)replaceImplementationOfClassMethodWithSelector:(SEL)selector withImplementation:(IMP)other
{
    Method m = class_getClassMethod(self, selector);
    return method_setImplementation(m, other);
}

@end
