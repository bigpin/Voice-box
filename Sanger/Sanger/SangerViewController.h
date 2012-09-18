//
//  SangerViewController.h
//  Sanger
//
//  Created by JiaLi on 12-7-14.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceShelfViewController.h"

@interface SangerViewController : UIViewController
{
    VoiceShelfViewController* _dataShelfViewController;
}

- (void)addTitleBarBackground;
@end
