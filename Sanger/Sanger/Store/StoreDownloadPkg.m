//
//  StoreDownloadPkg.m
//  Sanger
//
//  Created by JiaLi on 12-9-26.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "StoreDownloadPkg.h"
#import "Database.h"
#import "GTMHTTPFetcher.h"

@implementation StoreDownloadCourse
@synthesize pkgURL;
@synthesize course;
@synthesize pkgPath;
- (void)dealloc
{
    [self.pkgURL release];
    [self.course release];
    [super dealloc];
}

- (void)startDownload;
{
        NSString* path = [NSString stringWithFormat:@"%@/%@", self.pkgURL, course.file];
        NSURL* url = [NSURL URLWithString:path];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"cover" forHTTPHeaderField:@"User-Agent"];
        
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [fetcher beginFetchWithDelegate:self
                      didFinishSelector:@selector(fetcher:finishedWithData:error:)];
    

}

- (void)fetcher:(GTMHTTPFetcher*)fecther finishedWithData:(NSData*)data error:(id)error
{
    if (error != nil) {
        
    } else {
             NSString* xmlPath =  [NSString stringWithFormat:@"%@/index.xml", self.pkgPath];
            [data writeToFile:xmlPath atomically:YES];
    }
}


- (void)didDownloaded;
{
    
}
@end

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
    
    // copy cover
    NSString* coverPath = [NSString stringWithFormat:@"%@/cover", _pkgPath];
    if (self.info.receivedCoverImagePath != nil) {
        [fm copyItemAtPath:self.info.receivedCoverImagePath toPath:coverPath error:nil];
    }
    // insert info to database
    Database* db = [Database sharedDatabase];
    [db insertVoicePkgInfo:self.info];
    for (NSInteger i = 0; i < [self.info.dataPkgCourseInfoArray count]; i++) {
        DownloadDataPkgCourseInfo* course = [self.info.dataPkgCourseInfoArray objectAtIndex:i];
        NSString* courseFile = [NSString stringWithFormat:@"%@/%@", _pkgPath, course.title];
        
        // create path
        if (![fm fileExistsAtPath:courseFile isDirectory:nil])
            [fm createDirectoryAtPath:courseFile withIntermediateDirectories:YES attributes:nil error:nil];
        
        // download xml
        StoreDownloadCourse* downloadCourse = [[StoreDownloadCourse alloc] init];
        downloadCourse.pkgPath = courseFile;
        downloadCourse.pkgURL = self.info.url;
        downloadCourse.course = course;
        [downloadCourse startDownload];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DOWNLOADED_VOICE_PKGXML object:self.info.title];

}

- (void) dealloc
{
    [_pkgPath release];
    _pkgPath = nil;
    [super dealloc];
}
@end
