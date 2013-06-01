//
//  Harpy.h
//  Harpy
//
//  Created by Arthur Ariel Sabintsev on 11/14/12.
//  Copyright (c) 2012 Arthur Ariel Sabintsev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Harpy : NSObject <UIAlertViewDelegate>{
    NSMutableData *receiveData;
}
@property(nonatomic, strong) NSMutableData *receiveData;

- (void) checkVersion;
+ (void)showAlertWithAppStoreVersion:(NSString*)appStoreVersion;
@end
