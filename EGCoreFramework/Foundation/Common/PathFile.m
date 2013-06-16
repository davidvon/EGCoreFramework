//
//  Path.m
//  EGCoreFramework
//
//  Created by feng guanhua on 13-6-3.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "PathFile.h"


@implementation PathFile


//根据文件名来获取文件路径 doucument
+ (NSString *)fileInDocumentPath:(NSString *)sender
{
	return [[PathFile documentPath] stringByAppendingPathComponent:sender];
}


// 获取程序Documents目录路径
+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}


+ (NSArray *)allFilesInFolder:(NSString *)folderName{
	return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[self documentPath] stringByAppendingPathComponent:folderName] error:nil];
}

+ (NSArray *)allContentsInPath:(NSString *)directoryPath{
	return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
}


+ (NSArray *)allFilesInPathAndItsSubpaths:(NSString *)directoryPath{
	NSMutableArray *allContentsPathArray = [[[NSFileManager defaultManager] subpathsAtPath:directoryPath] mutableCopy];
	BOOL isDir = NO;
	for (int i = [allContentsPathArray count] - 1;i>=0;i--) {
		NSString *path = [allContentsPathArray objectAtIndex:i];
		if (![[NSFileManager defaultManager] fileExistsAtPath:[directoryPath stringByAppendingPathComponent:path] isDirectory:&isDir] || isDir) {
			[allContentsPathArray removeObject:path];
		}
	}
	return allContentsPathArray;
}

//返回目录下所有文件的名称(不包括路径)和大小
+ (NSMutableArray *)fileListInFolder:(NSString *)folderPath filterBySuffix:(NSString*)suffix
{
    NSArray *filesName = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSMutableArray *fileAttributes = [NSMutableArray new];
    for (NSString *fileName in filesName) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        BOOL isDir = false;
        BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir];
        if( [fileName.lowercaseString hasSuffix:suffix] && isExists && !isDir) {
            [fileAttributes addObject:fileName];
        }
    }
    return fileAttributes;
}
@end


