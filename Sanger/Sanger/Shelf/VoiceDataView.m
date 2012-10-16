//
//  VoiceDataView.m
//  Sanger
//
//  Created by JiaLi on 12-9-18.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "VoiceDataView.h"
#import <QuartzCore/QuartzCore.h>

@implementation VoiceDataView

@synthesize reuseIdentifier;
@synthesize selected= _selected;
@synthesize index = _index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _bookCover = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 70, 98)];
        //_bookCover.clipsToBounds = YES;
        /// _bookCover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _bookCover.layer.masksToBounds = YES;
        
        [self addSubview:_bookCover];
       
        _shadowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 20)];
        _shadowImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", @"mask_book.png"]];
        _shadowImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
       //[bookView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"mask_book.png"]] forState:UIControlStateNormal];
        [self addSubview:_shadowImageView];
        

        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, _shadowImageView.frame.size.height + 25, frame.size.width, 20)];
        _label.textAlignment = UITextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor whiteColor];
        [_label setFont:[UIFont systemFontOfSize:12]];
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_label];
        
        _checkedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BookViewChecked.png"]];
        [_checkedImageView setHidden:YES];
        [self addSubview:_checkedImageView];
        
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        [_checkedImageView setHidden:NO];
    }
    else {
        [_checkedImageView setHidden:YES];
    }
}

- (void)buttonClicked:(id)sender {
    [self setSelected:_selected ? NO : YES];
}

- (void)setBookCover:(UIImage*)im
{
    _bookCover.image = im;
}

- (void)setText:(NSString*)text;
{
    _label.text = text;
}

- (void)setFrame:(CGRect)frame
{
    V_NSLog(@"%f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    V_NSLog(@"_bookCover %f %f %f %f", _bookCover.frame.origin.x, _bookCover.frame.origin.y, _bookCover.frame.size.width, _bookCover.frame.size.height);
   // _bookCover.frame = _shadowImageView.frame;
    //_shadowImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 20);
    //_label.frame  = CGRectMake(0, _bookCover.frame.size.height - 20, frame.size.width, 20);
    super.frame = frame;
}
@end
