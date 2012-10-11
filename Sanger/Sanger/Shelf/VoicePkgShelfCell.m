//
//  VoicePkgShelfCell.m
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "VoicePkgShelfCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation VoicePkgShelfCell
@synthesize pkgImageView ;
@synthesize pkgTitle;
@synthesize index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       //self.backgroundColor = [UIColor greenColor];
        // Initialization code
        _bookCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
       // _bookCover.backgroundColor = [UIColor redColor];
        //_bookCover.clipsToBounds = YES;
        /// _bookCover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _bookCover.layer.masksToBounds = YES;
        
        [self addSubview:_bookCover];
        
        _shadowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(-15, -22, frame.size.width + 26, frame.size.height + 42)];
        _shadowImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", @"mask_book.png"]];
        _shadowImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        //[bookView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"mask_book.png"]] forState:UIControlStateNormal];
        [self addSubview:_shadowImageView];
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, _bookCover.frame.size.height + 4, frame.size.width, 20)];
        _label.textAlignment = UITextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor whiteColor];
        [_label setFont:[UIFont systemFontOfSize:12]];
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_label];
        
        
        //[self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [self.pkgImageView release];
    [self.pkgTitle release];
    [super dealloc];
}

- (void)setBookCover:(UIImage*)im
{
    _bookCover.image = im;
   // [_bookCover setImage:im forState:UIControlStateNormal];
}

- (void)setText:(NSString*)text;
{
    _label.text = text;
}

@end
