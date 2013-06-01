//
//  Harpy.m
//  Harpy
//
//  Created by Arthur Ariel Sabintsev on 11/14/12.
//  Copyright (c) 2012 Arthur Ariel Sabintsev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Harpy.h"
#import "HarpyConstants.h"
#import "JSONKit.h"

#define APPID @""
#define kHarpyCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]

@implementation Harpy
@synthesize receiveData;

#pragma mark - Public Methods
- (void)checkVersion
{
    // Asynchronously query iTunes AppStore for publically available version
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", APPID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3.0];    
    [request setHTTPMethod:@"GET"];

    receiveData = [[NSMutableData alloc] init];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection == nil) return;
}

// 接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *data = [[NSString alloc]
                         initWithBytes:[receiveData bytes]
                         length:[receiveData length]
                         encoding:NSUTF8StringEncoding];
    [self versionResponse:data];
}


-(void) versionResponse:(NSString*)data
{
    if ( [data length] > 0 ) {
        NSMutableArray *jsonData = [data objectFromJSONString];
        
        // All versions that have been uploaded to the AppStore
        NSArray *versionsInAppStore = [[jsonData valueForKey:@"results"] valueForKey:@"version"];
        
        if ( ![versionsInAppStore count] ) return;
        NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
        NSString *localVersion = kHarpyCurrentVersion;
        if ([localVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending) {
            [Harpy showAlertWithAppStoreVersion:currentAppStoreVersion];
        }
    }
}



#pragma mark - Private Methods
+ (void)showAlertWithAppStoreVersion:(NSString *)currentAppStoreVersion
{
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    if ( harpyForceUpdate ) { // Force user to update app
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kHarpyAlertViewTitle
                                                  message:[NSString stringWithFormat:@"%@ 有了新的版本%@, 赶紧去升级体验一下吧。", appName, currentAppStoreVersion] delegate:self
                                                  cancelButtonTitle:kHarpyUpdateButtonTitle
                                                  otherButtonTitles:nil, nil];
        
        [alertView show];
        
    } else { // Allow user option to update next time user launches your app
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kHarpyAlertViewTitle
                                                            message:[NSString stringWithFormat:@"%@ 有了新的版本%@, 赶紧去升级体验一下吧。", appName, currentAppStoreVersion]
                                                           delegate:self
                                                  cancelButtonTitle:kHarpyCancelButtonTitle
                                                  otherButtonTitles:kHarpyUpdateButtonTitle, nil];
        
        [alertView show];
    }
}


#pragma mark - UIAlertViewDelegate Methods
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if ( harpyForceUpdate ) {

        NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", APPID];
        NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
        [[UIApplication sharedApplication] openURL:iTunesURL];
        
    } else {

        switch ( buttonIndex ) {
                
            case 0:{ // Cancel / Not now
        
                // Do nothing
                
            } break;
                
            case 1:{ // Update
                
                NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", APPID];
                NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                [[UIApplication sharedApplication] openURL:iTunesURL];
                
            } break;
                
            default:
                break;
        }
        
    }

    
}

@end
