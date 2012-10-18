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
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       //self.backgroundColor = [UIColor greenColor];
        // Initialization code
        _bookCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
       //_bookCover.clipsToBounds = YES;
        /// _bookCover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _bookCover.layer.masksToBounds = YES;
        
        [self addSubview:_bookCover];
        CGFloat ySpace = IS_IPAD ? frame.origin.y - 56 : - 6;
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(_bookCover.frame.origin.x - 10, ySpace, 28, 28)];
        
        [_deleteButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"btn_delete.png"]] forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"btn_active.png"]] forState:UIControlStateSelected];
       
        [_deleteButton addTarget:self action:@selector(deleteCourcePkg:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_deleteButton];
        
        [_deleteButton release];
        [_deleteButton setHidden:YES];
        _bEdit = NO;
        NSInteger stretchHeight = IS_IPAD ? 34 : 42;
        NSInteger stretchWidth = IS_IPAD ? 26 : 28;
       NSInteger shadowY = IS_IPAD ? -18 : -22;
       _shadowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(-15, shadowY, frame.size.width + stretchWidth, frame.size.height + stretchHeight)];
        _shadowImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", @"mask_book.png"]];
        _shadowImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        //[bookView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"mask_book.png"]] forState:UIControlStateNormal];
        [self addSubview:_shadowImageView];
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(-30, _bookCover.frame.size.height + 4, frame.size.width + 60, 20)];
        _label.textAlignment = UITextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor whiteColor];
        [_label setFont:[UIFont systemFontOfSize:12]];
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_label];
        _bEdit = NO;
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(editPkg:) name:NOTIFICATION_EDIT_VOICE_PKG object:nil];

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
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:NOTIFICATION_EDIT_VOICE_PKG object:nil];
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

- (void)showEditBar:(BOOL)bShow;
{
    [_deleteButton setHidden:!bShow];
 }

- (void)editPkg:(NSNotification*)aNotification;
{
	NSNumber *numState = [aNotification object];
    if (numState == nil) {
        return;
    }
    BOOL edit = [numState boolValue];
    [self showEditBar:edit];
}

- (void)deleteCourcePkg:(id)sender;
{
    [self.delegate deletePkg:self];
}
@end
