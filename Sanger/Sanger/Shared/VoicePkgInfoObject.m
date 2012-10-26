//
//  VoiceDataPkgObject.m
//  Sanger
//
//  Created by JiaLi on 12-10-11.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "VoicePkgInfoObject.h"


@implementation DownloadServerInfo

static DownloadServerInfo* _serverInfo;
+ (DownloadServerInfo*)sharedDownloadServerInfo
{
	if (_serverInfo == nil) {
		_serverInfo = [[DownloadServerInfo alloc] init];
        
	}
	return _serverInfo;
}

@end
@implementation VoiceDataPkgObject
@synthesize  dataPath;
@synthesize  dataTitle;
@synthesize  dataCover;

- (void)dealloc
{
    [self.dataPath release];
    [self.dataTitle release];
    [self.dataCover release];
    [super dealloc];
}
@end

@implementation VoiceDataPkgObjectFullInfo

- (void)dealloc
{
    [self.url release];
    [self.createTime release];
    [super dealloc];
}

@end
@implementation DownloadDataPkgCourseInfo

@synthesize title;
@synthesize path;
@synthesize file;
@synthesize url;
@synthesize cover;
@synthesize receivedXMLPath;

- (void)dealloc
{
    [self.title release];
    [self.path release];
    [self.file release];
    [self.url release];
    [self.receivedXMLPath release];
    [super dealloc];
}
@end

@implementation DownloadDataPkgInfo

@synthesize receivedCoverImagePath;
@synthesize title;
@synthesize count;
@synthesize coverURL;
@synthesize url;
@synthesize intro;
@synthesize dataPkgCourseInfoArray;

- (void)dealloc
{
    [self.title release];
    [self.coverURL release];
    [self.url release];
    [self.intro release];
    [self.dataPkgCourseInfoArray release];
    [super dealloc];
}
@end
