//
//  Path.h
//  EGCoreFramework
//
//  Created by feng guanhua on 13-6-3.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathFile: NSObject
+ (NSString *)fileInDocumentPath:(NSString *)sender;
+ (NSString *)documentPath;
+ (NSArray *)allFilesInFolder:(NSString *)folderName;
+ (NSArray *)allContentsInPath:(NSString *)directoryPath;
+ (NSArray *)allFilesInPathAndItsSubpaths:(NSString *)directoryPath;
+ (NSMutableArray *)fileListInFolder:(NSString *)folderPath filterBySuffix:(NSString*)suffix;
@end




