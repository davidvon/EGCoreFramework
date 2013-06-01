//
//  constant.h
//  DishOrder
//
//  Created by feng guanhua on 13-4-29.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#ifndef DishOrder_constant_h
#define DishOrder_constant_h

#define GLOBAL_NAVIGATBAR_HEIGHT        50
#define MAIN_FRAME_WIDTH                768
#define MAIN_FRAME_HEIGHT               (1024-50)
#define PRODUCT_CELL_WIDTH              192
#define PRODUCT_CELL_HEIGHT             280
#define PRODUCT_FASTORDER_FRAME_HEIGHT  280
#define PRODUCT_FASTORDER_DETAIL_WIDTH  (1024 - 256 - PRODUCT_CELL_WIDTH - 10)
#define GLOBAL_FRAME_WIDTH              ([[UIScreen mainScreen] bounds].size.width > [[UIScreen mainScreen] bounds].size.height ? \
                                        [[UIScreen mainScreen] bounds].size.width:[[UIScreen mainScreen] bounds].size.height)

#define GLOBAL_TOOLBAR_SEARCH_TEXT      @"请输入菜名关键字"

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
+(UILabel*) addLabel: (CGRect)frame bgColor:(UIColor*)bgColor inView:(UIView*)view;
+ (UILabel*) addLabel: (CGRect)rect bgColor:(UIColor*)bgColor txtColor:(UIColor*)txtColor fontSize:(NSInteger)size withText:(NSString*)text inView:(UIView*)view ;

+ (UIImageView*) addImageView: (CGRect)rect withImageName:(NSString*)imageName inView:(UIView*)view;
+ (UIImageView*) addPatternImageView: (CGRect)rect withImageName:(NSString*)imageName inView:(UIView*)view;

+ (UIButton*) addButton: (CGRect)rect withImageList:(NSArray*)imageList fontSize:(NSInteger)size withText:(NSString*)text inView:(UIView*)view;
+ (UIButton*) addButton: (CGRect)rect withImage:(NSString*)image inView:(UIView*)view;

@end



@interface AppJsonDataSource : NSObject

+(int) getWidgetCount:(NSString*)pageName;
+(id) getPage:(NSString*)pageName;
+(id) getWidgetFromPage:(NSString*)widgetName fromPage:(NSString*)pageName;

@end



#endif





