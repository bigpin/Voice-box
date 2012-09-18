//
//  VoiceDataCellView.m
//  Sanger
//
//  Created by JiaLi on 12-9-18.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "VoiceDataCellView.h"

@implementation VoiceDataCellView

#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

@synthesize reuseIdentifier;

static UIImage *shadingImage = nil;
static UIImage *woodImage = nil;
static UIImage *shelfImageProtrait = nil;
static UIImage *shelfImageLandscape = nil;

+ (UIImage *)shadingImage {
    if (shadingImage == nil) {
        CGFloat scale = isRetina ? 2.0f : 1.0f;
        
        UIGraphicsBeginImageContext(CGSizeMake(320 * scale, 139 * scale));
        UIImage *shadingImageToDraw = [UIImage imageNamed:@"Side Shading-iPhone.png"];
        [shadingImageToDraw drawInRect:CGRectMake(0, 0, shadingImageToDraw.size.width * scale, shadingImageToDraw.size.height * scale)];
        
        CGAffineTransform ctm1 = CGAffineTransformMakeScale(-1.0f, 1.0f);
        CGContextConcatCTM(UIGraphicsGetCurrentContext(), ctm1);
        [shadingImageToDraw drawInRect:CGRectMake(-320 * scale, 0, shadingImageToDraw.size.width * scale, shadingImageToDraw.size.height * scale)];
        shadingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        shadingImage = [UIImage imageWithCGImage:shadingImage.CGImage scale:scale orientation:UIImageOrientationUp];
    }
    return shadingImage;
}

+ (UIImage *)woodImage {
    if (woodImage == nil) {
        CGFloat scale = isRetina ? 2.0f : 1.0f;
        
        UIGraphicsBeginImageContext(CGSizeMake(480 * scale, 139 * scale));
        UIImage *woodImageToDraw = [UIImage imageNamed:@"WoodTile.png"];
        [woodImageToDraw drawInRect:CGRectMake(0, 0, woodImageToDraw.size.width * scale, woodImageToDraw.size.width * scale)];
        woodImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        woodImage = [UIImage imageWithCGImage:woodImage.CGImage scale:scale orientation:UIImageOrientationUp];
    }
    return woodImage;
}

+ (UIImage *)shelfImageProtrait {
    if (shelfImageProtrait == nil) {
        shelfImageProtrait = [UIImage imageNamed:@"Shelf.png"];
    }
    return shelfImageProtrait;
}

+ (UIImage *)shelfImageLandscape {
    if (shelfImageLandscape == nil) {
        shelfImageLandscape = [UIImage imageNamed:@"Shelf-Landscape.png"];
    }
    return shelfImageLandscape;
}



- (UIImage *)partOfImage:(UIImage *)image rect:(CGRect)rect {
    UIGraphicsBeginImageContext(CGSizeMake(rect.size.width, rect.size.width));
    [image drawInRect:rect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
       /* NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
        NSString* stringResource = @"bg_bookshelf.png";
        NSString* imagePath = [NSString stringWithFormat:@"%@/%@", resourcePath, stringResource];
        UIImage* bgImage = [UIImage imageWithContentsOfFile:imagePath];
        self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
        self.autoresizesSubviews = UIViewAutoresizingFlexibleWidth;*/
       // [self setBackgroundColor:[UIColor whiteColor]];
       
        //_shelfImageView = [[UIImageView alloc] initWithImage:[VoiceDataCellView shelfImageProtrait]];
        
       // _shelfImageViewLandscape = [[UIImageView alloc] initWithImage:[VoiceDataCellView shelfImageLandscape]];
        
        //_woodImageView = [[UIImageView alloc] initWithImage:[VoiceDataCellView woodImage]];
        
        //_shadingImageView = [[UIImageView alloc] initWithImage:[VoiceDataCellView shadingImage]];
        //[_shadingImageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
        
        //[self addSubview:_woodImageView];
        //[self addSubview:_shadingImageView];
        //[self addSubview:_shelfImageView];
        //[self addSubview:_shelfImageViewLandscape];
    }
    return self;
}

/*- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_shadingImageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    if (self.frame.size.width <= 320) {
        [_shelfImageView setHidden:NO];
        [_shelfImageViewLandscape setHidden:YES];
    }
    else {
        [_shelfImageView setHidden:YES];
        [_shelfImageViewLandscape setHidden:NO];
    }
    [_shelfImageView setFrame:CGRectMake(0, 130 - 23, self.frame.size.width, _shelfImageView.frame.size.height)];
    [_shelfImageViewLandscape setFrame:CGRectMake(0, 130 - 23, self.frame.size.width, _shelfImageViewLandscape.frame.size.height)];
    
}
*/
@end
