//
//  VoicePkgShelfViewController.h
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoicePkgTableViewController.h"

@interface VoicePkgShelfViewController : UIViewController
{
    VoicePkgTableViewController* _pkgTable;
}
@property (nonatomic, assign) id<VoicePkgTableViewControllerDelegate>delegate;

- (void)reloadPkgShelf;
- (void)addNewPkg:(id)object;
@end
