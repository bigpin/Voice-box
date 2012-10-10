//
//  TKCoverView.m
//  Created by Devin Ross on 1/3/10.
//
/*
 
 tapku.com || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "TKCoverflowCoverView.h"
#import "UIImage+TKCategory.h"
#import "TKGlobal.h"




@implementation TKCoverflowCoverView
@synthesize baseline,gradientLayer;
@synthesize coverLabel = _coverLabel;
@synthesize scenesTitleLabel;

- (id) initWithFrame:(CGRect)frame {
    if(!(self=[super initWithFrame:frame])) return nil;
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    self.layer.anchorPoint = CGPointMake(0.5, 0.5);
    CGFloat heightOfLabel = [[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? 40 : 20;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    [self addSubview:imageView];
    reflected =  [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.width, self.frame.size.width, self.frame.size.width)];
    reflected.transform = CGAffineTransformScale(reflected.transform, 1, -1);
    [self addSubview:reflected];

    gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0 alpha:0.5].CGColor,(id)[UIColor colorWithWhite:0 alpha:1].CGColor,nil];
    gradientLayer.startPoint = CGPointMake(0,0);
    gradientLayer.endPoint = CGPointMake(0,0.3);
    gradientLayer.frame = CGRectMake(0, self.frame.size.width, self.frame.size.width, self.frame.size.width);
    [self.layer addSublayer:gradientLayer];
    UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height - heightOfLabel, imageView.frame.size.width, heightOfLabel)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor whiteColor];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        textLabel.font = [UIFont boldSystemFontOfSize:34];
    } else {
        textLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    textLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self addSubview:textLabel];
    self.coverLabel = textLabel;
    [textLabel release];
 
    heightOfLabel = heightOfLabel = [[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? 60 : 26;
    UILabel* textLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width/4, imageView.frame.size.height / 2 - heightOfLabel, imageView.frame.size.width, heightOfLabel)];
    textLabelTitle.backgroundColor = [UIColor clearColor];
    textLabelTitle.textColor = [UIColor whiteColor];
    if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        textLabelTitle.font = [UIFont boldSystemFontOfSize:58];
    } else {
        textLabelTitle.font = [UIFont boldSystemFontOfSize:24];
    }
    textLabelTitle.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self addSubview:textLabelTitle];
    self.scenesTitleLabel = textLabelTitle;
    [textLabelTitle release];

    
    
    return self;
}


- (void) setImage:(UIImage *)img{
	
	UIImage *image = img;
	[image release];
	image = [img retain];
	
	float w = image.size.width;
	float h = image.size.height;
	float factor = self.bounds.size.width / (h>w?h:w);
	h = factor * h;
	w = factor * w;
	float y = baseline - h > 0 ? baseline - h : 0;
	
	imageView.frame = CGRectMake(0, y, w, h);
	imageView.image = image;
	
	
	gradientLayer.frame = CGRectMake(0, y + h, w, h);
	
	reflected.frame = CGRectMake(0, y + h, w, h);
	reflected.image = image;
}

- (UIImage*) image{
	return imageView.image;
}
- (void) setBaseline:(float)f{
	baseline = f;
	[self setNeedsDisplay];
}

- (void) dealloc {
    [self.coverLabel release];
	[reflected release];
	[imageView release];
    [super dealloc];
}


@end
