//
//  RKPropertyIntrospectionTarget.h
//  ReflectionKit
//
//  Created by Maxthon Chan on 12/17/15.
//  Copyright © 2015 DreamCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKPropertyIntrospectionTarget : NSObject

@property NSString *NSString;
@property int NSNumber;
@property void *NSValue;
@property NSArray *NSArray;
@property id NSObject;
@property (readonly) id notAppear;

@end
