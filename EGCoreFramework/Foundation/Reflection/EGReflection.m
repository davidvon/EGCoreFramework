//
//  EGReflection.m
//  EGAppFramework
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "EGReflection.h"

@implementation EGReflection

+(void) performSelector:(NSString*)selName ofClass:(NSString*)className withParam:(id)object
{
    Class classType = NSClassFromString(className);
    id classInstance = [[classType alloc] init];
    
    SEL selector = NSSelectorFromString(selName);
    if ([classInstance respondsToSelector:selector]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [classInstance performSelector:selector withObject:object];
        #pragma clang diagnostic pop
    }
}


@end
