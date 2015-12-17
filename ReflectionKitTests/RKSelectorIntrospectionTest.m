//
//  RKSelectorIntrospectionTest.m
//  ReflectionKit
//
//  Created by Maxthon Chan on 12/17/15.
//  Copyright © 2015 DreamCity. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ReflectionKit/ReflectionKit.h>
#import "RKSelectorIntrospectionTarget.h"

@interface RKSelectorIntrospectionTest : XCTestCase

@property RKSelectorIntrospectionTarget *target;

@end

@implementation RKSelectorIntrospectionTest

- (void)setUp {
    [super setUp];
    
    self.target = [[RKSelectorIntrospectionTarget alloc] init];
}

- (void)tearDown {
    self.target = nil;
    
    [super tearDown];
}

- (void)testSelectorListing
{
    NSArray *selectors = self.target.allSelectors;
    
    XCTAssertEqual(selectors.count, 1UL);
    XCTAssertEqualObjects(selectors, @[@"someMethod"]);
}

@end
