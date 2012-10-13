//
//  VoicePkgTableViewController.h
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoicePkgInfoObject.h"

@protocol VoicePkgTableViewControllerDelegate <NSObject>

- (void)openVoiceData:(UIViewController*)controller;

@end

@interface VoicePkgTableViewController : UITableViewController
{
	CGSize szBookCover;
	NSInteger nCountPerRow;
	NSInteger nDY;
	UIImage *backgroundImage;
    NSMutableArray* _pkgArray;
}
@property (nonatomic, assign) id<VoicePkgTableViewControllerDelegate>delegate;
- (void)loadPkgArray;
- (void)checkPkgfromFolder;
- (void)reloadPkgTable;
@end
