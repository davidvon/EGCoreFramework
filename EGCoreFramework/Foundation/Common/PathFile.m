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


//判断文件是否存在
+ (bool) isFileExistsAtPath:(NSString *)folderPath fileName:(NSString*)name
{
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    for (NSString *temp in files) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:name];
        BOOL isDir = false;
        BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir];
        if( [temp.lowercaseString isEqualToString:name.lowercaseString] && isExists && !isDir) {
            return true;
        }
    }
    return false;
}



//删除目录下所有文件和文件夹
+ (void)filesDelete:(NSString *)folderPath
{
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSLog(@"files count=%d", [files count]);
    for (NSString *file in files) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:file];//转换成url
        BOOL isDir;  //判断该路径是不是文件夹
        BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir];//返回文件或文件夹是否存在
        if (isExists) {
            [self fileDelete:filePath];
         }
     }
}


//删除文件和文件夹
+ (BOOL)fileDelete:(NSString *)filePath{
    NSError *error=nil;
    BOOL isSucces=NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"要删除的地址不存在!!!filePath=%@", filePath);
        return NO;
    }
    
    isSucces=[[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];//调用删除方法
    if (error != nil) {
        NSLog(@"删除出错:%@", [error localizedDescription]);
    }else{
        NSLog(@"删除成功！");
    }
    return isSucces;
}


+ (NSArray *)allFilesInFolderPath:(NSString *)folderPath{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
}


+ (NSArray *)allFilesInPathAndItsSubpaths:(NSString *)directoryPath filterBySuffix:(NSString*)suffix 
{
	NSMutableArray *allContentsPathArray = [[[NSFileManager defaultManager] subpathsAtPath:directoryPath] mutableCopy];
	BOOL isDir = NO;
	for (int i = [allContentsPathArray count] - 1;i>=0;i--)
    {
		NSString *path = [allContentsPathArray objectAtIndex:i];
		if (![[NSFileManager defaultManager] fileExistsAtPath:[directoryPath stringByAppendingPathComponent:path] isDirectory:&isDir] || isDir) {
			[allContentsPathArray removeObject:path];
            continue;
		}
        if( !([path.lowercaseString hasSuffix:suffix])) {
            [allContentsPathArray removeObject:path];
            continue;
        }
	}
	return allContentsPathArray;
}


@end
