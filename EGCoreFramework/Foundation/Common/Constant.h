//
//  Constant.h
//  EGCoreFramework
//
//  Created by feng guanhua on 13-6-3.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>


#define GLOBAL_BG_COLOR                 ([UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1])
#define PRODUCT_BG_COLOR                ([UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1])
#define PRODUCT_SELECT_BG_COLOR         ([UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1])
#define CART_BG_COLOR                   ([UIColor colorWithRed:234/255.0f green:238/255.0f blue:242/255.0f alpha:1])
#define CART_BG_COLOR_2                 ([UIColor colorWithRed:220/255.0f green:228/255.0f blue:235/255.0f alpha:1])
#define WHITETRANS_BG_COLOR             [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]
#define WHITETRANS_TXT_COLOR            [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9]
#define CLEAR_COLOR                     [UIColor clearColor]
#define GRAY_COLOR                      [UIColor grayColor]
#define WHITE_COLOR                     [UIColor whiteColor]
#define BLACK_COLOR                     [UIColor blackColor]
#define BROWN_COLOR                     [UIColor brownColor]
#define DARKGRAY_COLOR                  [UIColor darkGrayColor]
#define ORANGE_COLOR                    [UIColor orangeColor]


@interface Constant: NSObject

+ (UILabel*) addLabel: (CGRect)frame bgColor:(UIColor*)bgColor inView:(UIView*)view;
+ (UILabel*) addLabel: (CGRect)rect bgColor:(UIColor*)bgColor txtColor:(UIColor*)txtColor fontSize:(NSInteger)size withText:(NSString*)text inView:(UIView*)view ;
+ (UIImageView*) addImageView: (CGRect)rect withImageName:(NSString*)imageName inView:(UIView*)view;
+ (UIImageView*) addPatternImageView: (CGRect)rect withImageName:(NSString*)imageName inView:(UIView*)view;
+ (UIButton*) addButton: (CGRect)rect withImageList:(NSArray*)imageList fontSize:(NSInteger)size withText:(NSString*)text inView:(UIView*)view;
+ (UIButton*) addButton: (CGRect)rect withImage:(NSString*)image inView:(UIView*)view;
+ (UIButton*) addButton: (CGRect)rect withImageList:(NSArray*)imageList inView:(UIView*)view;

+(UIScrollView*) addScrollView:(CGRect)rect inView:(UIView*)view;
+(UIWebView*) createWebView:(CGRect)rect;
+(UIWebView*) loadWebView:(CGRect)rect withUrlPath:(NSString*)path;
+(void) reloadWebViewContent:(UIWebView*)webView withUrlPath:(NSString*)path;

@end




