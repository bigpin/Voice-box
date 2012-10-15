//
//  Database.h
//  Voice
//
//  Created by JiaLi on 11-8-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VoicePkgInfoObject.h"

#define HISTORY_TABLE_NAME @"History"
#define HISTORY_ID         @"ID"

#define STRING_DB_TABLENAME_VOICE_PKG @"VoicePkgInfo"
#define STRING_DB_VOICE_PKG_ID         @"ID"
#define STRING_DB_VOICE_PKG_TITLE      @"Title"
#define STRING_DB_VOICE_PKG_PATH       @"Path"
#define STRING_DB_VOICE_PKG_COVER      @"Cover"
#define STRING_DB_VOICE_PKG_URL        @"URL"
#define STRING_DB_VOICE_PKG_CREATEDATE @"CreateDate"

#define STRING_DB_TABLENAME_PKG_DOWNLOADINFO @"VoicePkgDownloadInfo"
#define STRING_DB_VOICE_PKG_DOWNLOAD_FLAG    @"Flag"

@interface Database : NSObject {
 	Database* _database;
    NSLock *databaseLock; //mutex used to create our Critical Section
}

+ (Database*)sharedDatabase;
- (BOOL)createTable;
- (BOOL)createVoicePkgInfoTable;
- (BOOL)isExistsTable:(NSString*)tableName;
- (BOOL)insertVoicePkgInfo:(DownloadDataPkgInfo*)info;

// return VoiceDataPkgObject object
- (NSMutableArray*)loadVoicePkgInfo;
- (VoiceDataPkgObjectFullInfo*)loadVoicePkgInfoByTitle:(NSString*)title;
- (BOOL)deleteVoicePkgInfoByTitle:(NSString*)title;
- (NSString*)getAbsolutelyPath:(NSString*)path;

@end
