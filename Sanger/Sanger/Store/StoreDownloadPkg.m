//
//  StoreDownloadPkg.m
//  Sanger
//
//  Created by JiaLi on 12-9-26.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "StoreDownloadPkg.h"

@implementation StoreDownloadPkg
@synthesize info;

- (void)doDownload
{
    // check status by downloading plist
    // if  not download at all, post download message;
    // if received some data, post continued download message;
    // if finished download, post finished download;
    [self createDir];
}


- (void)createDir
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    documentDirectory = [documentDirectory stringByAppendingFormat:@"/%@", STRING_VOICE_PKG_DIR];
    
    // create pkg
    if (![fm fileExistsAtPath:documentDirectory isDirectory:nil])
        [fm createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];

    documentDirectory = [documentDirectory stringByAppendingFormat:@"/%@", self.info.title];

    if (![fm fileExistsAtPath:documentDirectory isDirectory:nil])
        [fm createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
   
    _pkgPath = [[NSString alloc] initWithFormat:@"%@", documentDirectory];

    for (NSInteger i = 0; i < [self.info.dataPkgCourseInfoArray count]; i++) {
        DataPkgCourseInfo* course = [self.info.dataPkgCourseInfoArray objectAtIndex:i];
        NSString* courseFile = [NSString stringWithFormat:@"%@/%@", _pkgPath, course.title];
        
        // create path
        if (![fm fileExistsAtPath:courseFile isDirectory:nil])
            [fm createDirectoryAtPath:courseFile withIntermediateDirectories:YES attributes:nil error:nil];
        
        // download xml
    }
}

- (void) dealloc
{
    [_pkgPath release];
    _pkgPath = nil;
    [super dealloc];
}
@end
