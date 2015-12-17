//
//  RKPropertyIntrospectionTest.m
//  ReflectionKit
//
//  Created by Maxthon Chan on 12/17/15.
//  Copyright © 2015 DreamCity. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReflectionKit/ReflectionKit.h>
#import "RKPropertyIntrospectionTarget.h"

@interface RKPropertyIntrospectionTest : XCTestCase

@property RKPropertyIntrospectionTarget *target;

@end

@implementation RKPropertyIntrospectionTest

- (void)setUp
{
    [super setUp];
    
    self.target = [[RKPropertyIntrospectionTarget alloc] init];
}

- (void)tearDown
{
    self.target = nil;
    
    [super tearDown];
}

- (void)testKeyDetection
{
    NSArray *keys = self.target.allKeys;
    
    XCTAssertNotNil(keys);
    XCTAssertEqual(keys.count, 5UL); // The id key should not appear.
}

- (void)testKeyClassDetection
{
    NSArray *keys = self.target.allKeys;
    
    for (NSString *key in keys)
    {
        XCTAssertEqualObjects(key, NSStringFromClass([self.target classForKey:key]));
    }
}

@end
