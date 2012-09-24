//
//  StorePkgDetailTableViewCell.m
//  Sanger
//
//  Created by JiaLi on 12-9-20.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "StorePkgDetailTableViewCell.h"
#import "GTMHTTPFetcher.h"

@implementation DetailCustomBackgroundView


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef graphicContext = UIGraphicsGetCurrentContext();
	CGColorSpaceRef colors_pace;
	size_t num_locations = 2;
	CGFloat locations[2] = { 0.0, 1.0};
	CGFloat components[8] = {0.8, 0.8, 0.8, 1.0,
		VALUE_DETAIL_STORE_BACKGROUND_COLOR1, VALUE_DETAIL_STORE_BACKGROUND_COLOR1, VALUE_DETAIL_STORE_BACKGROUND_COLOR1, 1.0 };
	
	
	colors_pace =  CGColorSpaceCreateDeviceRGB();;
	CGGradientRef gradientRef = CGGradientCreateWithColorComponents (colors_pace, components,
                                                                     locations, num_locations);
	
	CGPoint ptStart, ptEnd;
	ptStart.x = 0.0;
	ptStart.y = 0.0;
	ptEnd.x = 0.0;
	ptEnd.y = rect.size.height;
	CGContextDrawLinearGradient (graphicContext, gradientRef, ptStart, ptEnd, 0);
    CGColorSpaceRelease(colors_pace);
 }
 
- (void)dealloc {
    [super dealloc];
}



@end

@implementation StorePkgDetailTableViewCell
@synthesize coverImageView, titleLabel, downloadButton;

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

- (void)setButtomImage
{
    [self.downloadButton setTitle:STRING_DOWNLOAD forState:UIControlStateNormal];
    UIImage *greenButtonImage = [UIImage imageNamed:@"buttonblue_normal.png"];
    UIImage *stretchableGreenButton = [greenButtonImage stretchableImageWithLeftCapWidth:6 topCapHeight:6];
    [self.downloadButton setBackgroundImage:stretchableGreenButton forState:UIControlStateNormal];
    
    UIImage *darkGreenButtonImage = [UIImage imageNamed:@"buttonblue_pressed.png"];
    UIImage *stretchabledarkGreenButton = [darkGreenButtonImage stretchableImageWithLeftCapWidth:6 topCapHeight:6];
    [self.downloadButton setBackgroundImage:stretchabledarkGreenButton forState:UIControlStateHighlighted];
}

- (void)setVoiceData:(DataPkgInfo*)info
{
    [self setButtomImage];
    _info = info;
    self.titleLabel.text = info.title;
     if (info.receivedCoverImagePath == nil) {
        // download cover
        NSString* url = info.url;
        NSString* coverUrl = info.coverURL;
        if (coverUrl != nil && url != nil) {
            NSString* path = [NSString stringWithFormat:@"%@/%@", url, coverUrl];
            NSURL* url = [NSURL URLWithString:path];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request setValue:@"cover" forHTTPHeaderField:@"User-Agent"];
            
            GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
            [fetcher beginFetchWithDelegate:self
                          didFinishSelector:@selector(fetcher:finishedWithData:error:)];
            
        }
        
    } else {
        UIImage* im = [UIImage imageWithContentsOfFile:info.receivedCoverImagePath];
        self.coverImageView.image = im;
    }
}

- (void)fetcher:(GTMHTTPFetcher*)fecther finishedWithData:(NSData*)data error:(id)error
{
    if (error != nil) {
        
    } else {
        if (_info != nil) {
            NSString* pngPath =  [NSString stringWithFormat:@"%@%d", NSTemporaryDirectory(),(arc4random())];
            [data writeToFile:pngPath atomically:YES];
            _info.receivedCoverImagePath = pngPath;
            UIImage* im = [UIImage imageWithData:data];
            self.coverImageView.image = im;
        }
    }
}

- (void) dealloc
{
    _info = nil;
    [super dealloc];
}

@end
