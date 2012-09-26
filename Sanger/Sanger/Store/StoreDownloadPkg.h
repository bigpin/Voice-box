//
//  StoreDownloadPkg.h
//  Sanger
//
//  Created by JiaLi on 12-9-26.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreVoiceDataListParser.h"

@interface StoreDownloadPkg : NSObject
{
    NSString* _pkgPath;
}
@property (nonatomic, retain) DataPkgInfo* info;

- (void)doDownload;

@end
