//
//  StoreCourceTableViewCell.h
//  Sanger
//
//  Created by JiaLi on 12-9-25.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoicePkgInfoObject.h"

@interface StoreCourceTableViewCell : UITableViewCell
{
    DownloadDataPkgCourseInfo* _course;
}

- (void)setCourseData:(DownloadDataPkgCourseInfo*)course withURL:(NSString*)parentURL;

@end
