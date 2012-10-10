//
//  StorePkgDetailTableViewCell.m
//  Sanger
//
//  Created by JiaLi on 12-9-20.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "StorePkgDetailTableViewCell.h"
#import "GTMHTTPFetcher.h"
#import "StoreDownloadPkg.h"

@implementation DetailCustomBackgroundView
@synthesize bUpToDown;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
        bUpToDown = YES;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef graphicContext = UIGraphicsGetCurrentContext();
	CGColorSpaceRef colors_pace;
	size_t num_locations = 2;
	CGFloat locations[2] = { 0.0, 1.0};
	
	
	colors_pace =  CGColorSpaceCreateDeviceRGB();;
	CGGradientRef gradientRef;
    if (bUpToDown) {
        CGFloat componentsupToDown[8] = {0.9, 0.9, 0.9, 1.0,
            VALUE_DETAIL_STORE_BACKGROUND_COLOR1_R, VALUE_DETAIL_STORE_BACKGROUND_COLOR1_G, VALUE_DETAIL_STORE_BACKGROUND_COLOR1_B, 1.0 };
       gradientRef = CGGradientCreateWithColorComponents (colors_pace, componentsupToDown,
                                               locations, num_locations);
    } else {
        CGFloat componentsDownToUp[8] = {
            VALUE_DETAIL_STORE_BACKGROUND_COLOR1_R, VALUE_DETAIL_STORE_BACKGROUND_COLOR1_G, VALUE_DETAIL_STORE_BACKGROUND_COLOR1_B, 1.0,  0.9, 0.9, 0.9, 1.0 };
        gradientRef = CGGradientCreateWithColorComponents (colors_pace, componentsDownToUp,
                                                           locations, num_locations);
        
    }
	
	CGPoint ptStart, ptEnd;
	ptStart.x = 0.0;
	ptStart.y = 0.0;
	ptEnd.x = 0.0;
	ptEnd.y = rect.size.height;
	CGContextDrawLinearGradient (graphicContext, gradientRef, ptStart, ptEnd, 0);
    CGColorSpaceRelease(colors_pace);
    
    CGFloat lineColor[] = {0.7, 0.7, 0.7, 1.0};
    CGContextSetStrokeColor(graphicContext, lineColor);
    CGContextSetLineWidth(graphicContext, 1);
    if (bUpToDown) {
        CGContextMoveToPoint(graphicContext, 0, 0);
        CGContextAddLineToPoint(graphicContext, rect.size.width, 0);
    } else {
        CGContextMoveToPoint(graphicContext, 0, rect.size.height);
        CGContextAddLineToPoint(graphicContext, rect.size.width, rect.size.height);
    }
    CGContextStrokePath(graphicContext);
 }
 
- (void)dealloc {
    [super dealloc];
}



@end

@implementation StorePkgDetailTableViewCell
@synthesize coverImageView, titleLabel, downloadButton;
@synthesize delegate;

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

- (IBAction)clickButton:(id)sender
{
    if ([[self.downloadButton titleForState:UIControlStateNormal] isEqual:STRING_DOWNLOAD]) {
        // begin download
        [self.downloadButton  setTitle:STRING_DOWNLOADING forState:UIControlStateNormal];
        self.downloadButton.enabled = NO;
        [self.delegate doDownload];
        /*StoreDownloadPkg* downloadPkg = [[StoreDownloadPkg alloc] init];
        downloadPkg.info = _info;
        [downloadPkg doDownload];*/
    }
}

@end
