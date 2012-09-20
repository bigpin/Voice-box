//
//  StorePkgDetailViewController.h
//  Sanger
//
//  Created by JiaLi on 12-9-20.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreVoiceDataListParser.h"

@interface StorePkgDetailViewController : UITableViewController

@property (nonatomic, retain, readwrite) DataPkgInfo* info;

+ (CGSize)calcTextHeight:(NSString *)str withWidth:(CGFloat)width withFontSize:(CGFloat)fontSize;

@end
