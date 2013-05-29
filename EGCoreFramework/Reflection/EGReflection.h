//
//  EGReflection.h
//  EGAppFramework
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 - (BOOL)isKindOfClass:(Class)aClass
 Returns a Boolean value that indicates whether the receiver is an instance of given class or an instance of any class that inherits from that class.
 
 - (BOOL)isMemberOfClass:(Class)aClass
 Returns a Boolean value that indicates whether the receiver is an instance of a given class.
 
 - (BOOL)respondsToSelector:(SEL)aSelector
 Returns a Boolean value that indicates whether the receiver implements or inherits a method that can respond to a specified message.
 
 - (BOOL)conformsToProtocol:(Protocol *)aProtocol
 Returns a Boolean value that indicates whether the receiver conforms to a given protocol. 
 */

@interface EGReflection : NSObject

+(void) performSelector:(NSString*)selName ofClass:(NSString*)className withParam:(id)object;
@end
