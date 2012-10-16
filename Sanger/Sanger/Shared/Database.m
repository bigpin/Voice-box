//
//  Database.m
//  Voice
//
//  Created by JiaLi on 11-8-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Database.h"
#import <sqlite3.h>
#import "VoiceDef.h"

@implementation Database

static Database* _database;

+ (Database*)sharedDatabase
{
	if (_database == nil) {
		_database = [[Database alloc] init];
	}
	
	return _database;
}

- (id)init
{
	if ((self = [super init])) {
        NSError *error = nil;
        NSFileManager * fileMgr = [NSFileManager defaultManager];
		NSArray* libary =  NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString *libaryDir =  [libary objectAtIndex:0];
		
        NSString* userdata = PATH_USERDATA;
		NSString *sqlitePath = [libaryDir stringByAppendingString:userdata];
        if (![fileMgr fileExistsAtPath:sqlitePath isDirectory:nil])  
            [fileMgr createDirectoryAtPath:sqlitePath withIntermediateDirectories:YES attributes:nil error:nil];	

        NSString* dirdatabase = DIR_DATABASE;
		sqlitePath = [sqlitePath stringByAppendingPathComponent:dirdatabase];
        if (![fileMgr fileExistsAtPath:sqlitePath isDirectory:nil])  
            [fileMgr createDirectoryAtPath:sqlitePath withIntermediateDirectories:YES attributes:nil error:nil];	

        NSString* databaseName = DATABASE_NAME;
		sqlitePath = [sqlitePath stringByAppendingPathComponent:databaseName];
        if (![fileMgr fileExistsAtPath:sqlitePath isDirectory:nil]) {
            NSString *homePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", dirdatabase];
            
            NSString *copyFromDatabasePath = [homePath stringByAppendingPathComponent:databaseName];
            [fileMgr copyItemAtPath:copyFromDatabasePath toPath:sqlitePath error:&error];
         } else {
           
        }
        int openResult = sqlite3_open([sqlitePath UTF8String], (sqlite3 **)(&_database));
		if (openResult == SQLITE_OK) {
            V_NSLog(@"%@", @"sqlite3_open ok");
 		} else {
            V_NSLog(@"%@", @"sqlite3_open failed");
           
        }
		databaseLock = [[NSLock alloc] init];
        [self createVoicePkgInfoTable];
	}
	return self;
}

- (BOOL)createVoicePkgInfoTable;
{
    NSString* tableName = STRING_DB_TABLENAME_VOICE_PKG;
    if ([self isExistsTable:tableName]) {
        return NO;
	}
	
	[databaseLock lock];
	sqlite3_stmt *statement;
	BOOL bSuccess = NO;
	NSMutableString  *sql =[[NSMutableString alloc] initWithFormat:@"Create TABLE MAIN.[%@]", tableName];
	[sql appendString:@"("];
	[sql appendFormat:@"[%@] integer PRIMARY KEY UNIQUE NOT NULL",STRING_DB_VOICE_PKG_ID];
	[sql appendFormat:@",[%@] varchar",STRING_DB_VOICE_PKG_TITLE];
	[sql appendFormat:@",[%@] varchar",STRING_DB_VOICE_PKG_PATH];
 	[sql appendFormat:@",[%@] varchar",STRING_DB_VOICE_PKG_COVER];
	[sql appendFormat:@",[%@] varchar",STRING_DB_VOICE_PKG_URL];
 	[sql appendFormat:@",[%@] varchar",STRING_DB_VOICE_PKG_CREATEDATE];
	[sql appendString:@");"];
	
	int success = sqlite3_prepare_v2((sqlite3 *)_database, [sql UTF8String], -1, &statement, NULL);
	if (success == SQLITE_OK) {
		success = sqlite3_step(statement);
	} else {
		
	}
	sqlite3_finalize(statement);
	[sql release];
	[databaseLock unlock];
	return bSuccess;
}
- (BOOL)createTable;
{
    return YES;
    /*NSString* history = HISTORY_TABLE_NAME;
    if ([self isExistsTable:history]) {
        return NO;
	}
	
	[databaseLock lock];
	sqlite3_stmt *statement;
	BOOL bSuccess = NO;
	NSMutableString  *sql =[[NSMutableString alloc] initWithFormat:@"Create TABLE MAIN.[%@]", history];
	[sql appendString:@"("];
	[sql appendFormat:@"[%@] integer PRIMARY KEY UNIQUE NOT NULL",LIB_LINE_FILEID];
	[sql appendFormat:@",[%@] varchar",LIB_LINE_ORG_NAME];
	[sql appendFormat:@",[%@] varchar",LIB_LINE_USER_NAME];
	[sql appendString:@");"];	
	
	int success = sqlite3_prepare_v2((sqlite3 *)_database, [sql UTF8String], -1, &statement, NULL);
	if (success == SQLITE_OK) {
		success = sqlite3_step(statement);
	} else {
		
	}
	sqlite3_finalize(statement);
	[sql release];
	[databaseLock unlock];
	return bSuccess;*/	

}

- (BOOL)isExistsTable:(NSString*)tableName;
{
	BOOL bExist = NO;
	[databaseLock lock];
	sqlite3_stmt *statement;
    NSMutableString  *sql =[[NSMutableString alloc] initWithFormat:@"select name from sqlite_master WHERE type = %@ AND name = '%@'", @"\"table\"", tableName];
	int success = sqlite3_prepare_v2((sqlite3 *)_database, [sql UTF8String], -1, &statement, NULL);
    if (success == SQLITE_OK) {
		if (sqlite3_step(statement) == SQLITE_ROW) {
			bExist = YES;
		}
    } else {
		
	}
	sqlite3_finalize(statement);
	[sql release];
	[databaseLock unlock];
	return bExist;
}

- (BOOL)insertVoicePkgInfo:(DownloadDataPkgInfo*)info;
{
 	/*int fileID = [self getFileIDbyPath:book.path];
	if (fileID != -1)
		return NO;
    */
	// insert a new record
	[databaseLock lock];
	sqlite3_stmt *statement;

    NSString* sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@,%@,%@,%@) VALUES(?,?,?,?,?,?)", STRING_DB_TABLENAME_VOICE_PKG, STRING_DB_VOICE_PKG_ID, STRING_DB_VOICE_PKG_TITLE, STRING_DB_VOICE_PKG_PATH, STRING_DB_VOICE_PKG_COVER, STRING_DB_VOICE_PKG_URL, STRING_DB_VOICE_PKG_CREATEDATE];
	//NSString  *sql = @"INSERT INTO FileInfo (FileID, FilePath, FileFormat, GroupID, OrderInGroup, FileSourceID, DateAdded, Title, Author, Publisher, PublishDate ,TotalPageCount, FileSize, CoverPath, IDentifier) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	int success = sqlite3_prepare_v2((sqlite3 *)_database, [sql UTF8String], -1, &statement, NULL);
	if (success == SQLITE_OK) {
		//sqlite3_bind_text(statement, 1, [channel.userID UTF8String], -1, SQLITE_TRANSIENT);
		NSInteger i = 2;
        
        // title
		sqlite3_bind_text(statement, i, [info.title UTF8String], -1, SQLITE_TRANSIENT);
		i++;
        
        // path
		sqlite3_bind_text(statement, i, [info.title UTF8String], -1, SQLITE_TRANSIENT);
		i++;
        

        // cover
        sqlite3_bind_text(statement, i, [@"" UTF8String], -1, SQLITE_TRANSIENT);
		i++;
        
        // url
        sqlite3_bind_text(statement, i, [info.url UTF8String], -1, SQLITE_TRANSIENT);
		i++;
      
        // createTime
        NSDate* d = [NSDate date];
        sqlite3_bind_text(statement, i, [[d description] UTF8String], -1, SQLITE_TRANSIENT);
		i++;
        
        success = sqlite3_step(statement);
		sqlite3_finalize(statement);
		[databaseLock unlock];
		if (success == SQLITE_ERROR) {
			V_NSLog(@"Error: failed to %@", @"insertVoicePkgInfo");
			return NO;
		}
	} else {
		[databaseLock unlock];
		V_NSLog(@"Error: failed to %@", @"insertVoicePkgInfo");
		return NO;
	}
    
    return YES;
}

- (NSMutableArray*)loadVoicePkgInfo;
{
   	[databaseLock lock];
	NSMutableArray * arrResult = [[NSMutableArray alloc] init];
	sqlite3_stmt *statement;
    NSMutableString  *sql =[[NSMutableString alloc] initWithFormat:@"SELECT %@, %@ FROM %@",STRING_DB_VOICE_PKG_PATH, STRING_DB_VOICE_PKG_TITLE, STRING_DB_TABLENAME_VOICE_PKG];
	int success = sqlite3_prepare_v2((sqlite3 *)_database, [sql UTF8String], -1, &statement, NULL);
    if (success == SQLITE_OK) {
		while (sqlite3_step(statement) == SQLITE_ROW) {
            VoiceDataPkgObject* pkgObject = [[VoiceDataPkgObject alloc] init];
            char *pathChars = (char *) sqlite3_column_text(statement, 0);
            char *titleChars = (char *) sqlite3_column_text(statement, 1);
            //char *coverChars = (char *) sqlite3_column_text(statement, 2);
            if (pathChars != nil) {
                NSString *path = [NSString stringWithUTF8String:pathChars];
                pkgObject.dataPath = [NSString stringWithFormat:@"%@", [self getAbsolutelyPath:path]];
                pkgObject.dataCover = [NSString stringWithFormat:@"%@/cover", [self getAbsolutelyPath:path]] ;
            }
            if (titleChars != nil) {
                NSString *title = [NSString stringWithUTF8String:pathChars];
                pkgObject.dataTitle = [NSString stringWithFormat:@"%@",title];
            }
            [arrResult addObject:pkgObject];
 			
		}
    } else {
	}
	sqlite3_finalize(statement);
	[sql release];
	[databaseLock unlock];
	
	return arrResult;
}

- (VoiceDataPkgObjectFullInfo*)loadVoicePkgInfoByTitle:(NSString*)title;
{
    [databaseLock lock];
	VoiceDataPkgObjectFullInfo* info = nil;
	sqlite3_stmt *statement;
    NSString  *sql =[[NSString alloc] initWithFormat:@"SELECT %@, %@, %@, %@, %@  FROM %@ WHERE %@ = '%@'",  STRING_DB_VOICE_PKG_TITLE, STRING_DB_VOICE_PKG_PATH, STRING_DB_VOICE_PKG_COVER, STRING_DB_VOICE_PKG_URL, STRING_DB_VOICE_PKG_CREATEDATE, STRING_DB_TABLENAME_VOICE_PKG, STRING_DB_VOICE_PKG_TITLE, title];
	int success = sqlite3_prepare_v2((sqlite3 *)_database, [sql UTF8String], -1, &statement, NULL);
    if (success == SQLITE_OK) {
		while (sqlite3_step(statement) == SQLITE_ROW) {
            info = [[VoiceDataPkgObjectFullInfo alloc] init];
            char *titleChars = (char *) sqlite3_column_text(statement, 0);
            char *pathChars = (char *) sqlite3_column_text(statement, 1);
            //char *coverChars = (char *) sqlite3_column_text(statement, 2);
           // coverChars;
            char *urlChars = (char *) sqlite3_column_text(statement, 3);
            char *timeChars = (char *) sqlite3_column_text(statement, 4);
             //char *coverChars = (char *) sqlite3_column_text(statement, 2);
            if (pathChars != nil) {
                NSString *path = [NSString stringWithUTF8String:pathChars];
                info.dataPath = [NSString stringWithFormat:@"%@", [self getAbsolutelyPath:path]];
                info.dataCover = [NSString stringWithFormat:@"%@/cover", [self getAbsolutelyPath:path]] ;
            }
            if (titleChars != nil) {
                NSString *title = [NSString stringWithUTF8String:titleChars];
                info.dataTitle = [NSString stringWithFormat:@"%@",title];
            }
            if (urlChars != nil) {
                NSString *title = [NSString stringWithUTF8String:urlChars];
                info.url = [NSString stringWithFormat:@"%@",title];
            }
            if (timeChars != nil) {
                NSString *title = [NSString stringWithUTF8String:timeChars];
                info.createTime = [NSString stringWithFormat:@"%@",title];
            }
            break;
 			
		}
    } else {
	}
	sqlite3_finalize(statement);
	[sql release];
	[databaseLock unlock];
	
	return [info autorelease];

}

- (BOOL)deleteVoicePkgInfoByTitle:(NSString*)title;
{
    BOOL bOK = YES;
	[databaseLock lock];
	sqlite3_stmt *statement;
    NSString  *sql =[[NSString alloc] initWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'", STRING_DB_TABLENAME_VOICE_PKG, STRING_DB_VOICE_PKG_TITLE, title];
	int success = sqlite3_prepare_v2((sqlite3 *)_database, [sql UTF8String], -1, &statement, NULL);
    if (success == SQLITE_OK) {
		success = sqlite3_step(statement);
		if (success == SQLITE_ERROR) {
			bOK = NO;
		}
    } else {
		bOK = NO;
	}
	sqlite3_finalize(statement);
	[sql release];
	[databaseLock unlock];
	return bOK;

}
- (NSString*)getPathRelative:(NSString*)path;
{
	if (path == nil) {
		return nil;
	}
    
	NSString *filePath = [NSString stringWithString:path];
	NSRange rangeDocument = [filePath rangeOfString:SUB_DIR_DOCUMENT options:NSBackwardsSearch];
	if (rangeDocument.location != NSNotFound){
		NSInteger nSubFromIndex = rangeDocument.location + rangeDocument.length;
		if (nSubFromIndex < filePath.length) {
			filePath = [filePath substringFromIndex:nSubFromIndex];
		}
        
        return filePath;
	}
    
	rangeDocument = [filePath rangeOfString:SUB_DIR_CACHE options:NSBackwardsSearch];
	if (rangeDocument.location != NSNotFound){
		NSInteger nSubFromIndex = rangeDocument.location + rangeDocument.length;
		if (nSubFromIndex < filePath.length) {
			filePath = [filePath substringFromIndex:nSubFromIndex];
		}
	}
    
	return filePath;
}

- (NSString*)getAbsolutelyPath:(NSString*)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    documentDirectory = [documentDirectory stringByAppendingFormat:@"/%@", STRING_VOICE_PKG_DIR];
    
     
    documentDirectory = [documentDirectory stringByAppendingFormat:@"/%@", path];
    
    NSString* absolutePath = [NSString stringWithFormat:@"%@", documentDirectory];
    return absolutePath;
}
@end
