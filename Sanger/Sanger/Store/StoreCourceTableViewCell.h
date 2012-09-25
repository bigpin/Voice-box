//
//  StoreCourceTableViewCell.h
//  Sanger
//
//  Created by JiaLi on 12-9-25.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreVoiceDataListParser.h"

@interface StoreCourceTableViewCell : UITableViewCell
{
    DataPkgCourseInfo* _course;
}

- (void)setCourseData:(DataPkgCourseInfo*)course withURL:(NSString*)parentURL;

@end
