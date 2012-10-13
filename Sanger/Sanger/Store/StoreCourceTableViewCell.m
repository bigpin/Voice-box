//
//  StoreCourceTableViewCell.m
//  Sanger
//
//  Created by JiaLi on 12-9-25.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "StoreCourceTableViewCell.h"
#import "GTMHTTPFetcher.h"
@implementation StoreCourceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCourseData:(DownloadDataPkgCourseInfo*)course withURL:(NSString*)parentURL;
{
     _course = course;
    if (_course.receivedXMLPath == nil) {
        NSString* path = [NSString stringWithFormat:@"%@/%@", parentURL, course.file];
        NSURL* url = [NSURL URLWithString:path];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"cover" forHTTPHeaderField:@"User-Agent"];
        
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [fetcher beginFetchWithDelegate:self
                      didFinishSelector:@selector(fetcher:finishedWithData:error:)];
    }
}

- (void)fetcher:(GTMHTTPFetcher*)fecther finishedWithData:(NSData*)data error:(id)error
{
    if (error != nil) {
        
    } else {
        if (_course != nil) {
            NSString* xmlPath =  [NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(),_course.file];
            [data writeToFile:xmlPath atomically:YES];
            _course.receivedXMLPath = xmlPath;
         }
    }
}

@end
