//
//  VoicePkgTableViewController.h
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceDataPkgObject : NSObject

@property (nonatomic, retain) NSString* dataPath;
@property (nonatomic, retain) NSString* dataTitle;
@property (nonatomic, retain) NSString* dataCover;
@property (nonatomic, retain) NSNumber* dataNumber;
@end

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
- (void)reloadPkgTable;
@end
