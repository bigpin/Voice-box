//
//  StoreDownloadPkg.h
//  Sanger
//
//  Created by JiaLi on 12-9-26.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VoicePkgInfoObject.h"

@interface StoreDownloadCourse : NSObject
{
    
}
@property (nonatomic, retain) DownloadDataPkgCourseInfo* course;
@property (nonatomic, retain) NSString* pkgURL;
@property (nonatomic, retain) NSString* pkgPath;

- (void)startDownload;
- (void)didDownloaded;
@end

@interface StoreDownloadPkg : NSObject
{
    NSString* _pkgPath;
}
@property (nonatomic, retain) DownloadDataPkgInfo* info;

- (void)doDownload;

@end
