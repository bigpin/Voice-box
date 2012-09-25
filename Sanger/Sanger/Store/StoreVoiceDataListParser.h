//
//  StoreVoiceDataListParser.h
//  Sanger
//
//  Created by JiaLi on 12-9-19.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface DataPkgCourseInfo : NSObject
@property (nonatomic, retain, readwrite) NSString* title;
@property (nonatomic, retain, readwrite) NSString* path;
@property (nonatomic, retain, readwrite) NSString* file;
@property (nonatomic, retain, readwrite) NSString* cover;
@property (nonatomic, retain, readwrite) NSString* url;
@property (nonatomic, retain, readwrite) NSString* receivedXMLPath;
@end

@interface DataPkgInfo :NSObject
@property (nonatomic, retain, readwrite) NSString* title;
@property (nonatomic, assign, readwrite) NSInteger count;
@property (nonatomic, retain, readwrite) NSString* coverURL;
@property (nonatomic, retain, readwrite) NSString* url;
@property (nonatomic, retain, readwrite) NSString* intro;
@property (nonatomic, retain, readwrite) NSMutableArray* dataPkgCourseInfoArray;
@property (nonatomic, retain, readwrite) NSString* receivedCoverImagePath;
@end    


@interface StoreVoiceDataListParser : NSObject

@property (nonatomic, retain, readwrite) NSMutableArray* pkgsArray;
- (void)loadWithPath:(NSString*)path;
- (void)loadWithData:(NSData*)data;

@end
