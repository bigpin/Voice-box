//
//  VoicePkgTableViewController.h
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoicePkgInfoObject.h"
#import "VoicePkgShelfCell.h"

@protocol VoicePkgTableViewControllerDelegate <NSObject>

- (void)openVoiceData:(UIViewController*)controller;

@end

@interface VoicePkgTableViewController : UITableViewController<UIGestureRecognizerDelegate>
{
	CGSize szBookCover;
	NSInteger nCountPerRow;
	NSInteger nDY;
    CGFloat _ySpace;
	UIImage *backgroundImage;
    NSMutableArray* _pkgArray;
    BOOL _bEdit;
    VoiceDataPkgObject* _deleteObject;
    NSString* _willOpenCourseTitle;
}

@property (nonatomic, assign) id<VoicePkgTableViewControllerDelegate>delegate;
- (void)loadPkgArray;
- (void)checkPkgfromFolder;
- (void)reloadPkgTable;
- (void)addAction:(VoicePkgShelfCell*)v;
- (void)delayOpenCourse;
@end
