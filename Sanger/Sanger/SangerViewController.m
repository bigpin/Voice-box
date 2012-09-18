//
//  SangerViewController.m
//  Sanger
//
//  Created by JiaLi on 12-7-14.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "SangerViewController.h"
#import "StoreViewController.h"
#import "VoiceShelfViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SangerViewController ()

@end

@implementation SangerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // buttons
    self.title = STRING_MY_DATA_CENTER;
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    //[self addTitleBarBackground];
     
	// Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem* storeItem = [[UIBarButtonItem alloc] initWithTitle:STRING_DATA_CENTER style:UIBarButtonItemStyleBordered target:self action:@selector(gotoStore)];
    self.navigationItem.rightBarButtonItem = storeItem;
    [storeItem release];
    
    NSString* settingResouce = @"icon_setting.png";
    NSString* settingimagePath = [NSString stringWithFormat:@"%@/%@", resourcePath, settingResouce];
   UIImage* settingImage = [UIImage imageWithContentsOfFile:settingimagePath];
    UIBarButtonItem* setting = [[UIBarButtonItem alloc] initWithImage:settingImage style:UIBarButtonItemStyleBordered target:self action:@selector(gotoSetting)];
    
    self.navigationItem.leftBarButtonItem = setting;
    [setting release];
    
    // backgroundColor
    NSString* stringResource = @"bg_bookshelf.png";
    NSString* imagePath = [NSString stringWithFormat:@"%@/%@", resourcePath, stringResource];
    UIImage* bgImage = [UIImage imageWithContentsOfFile:imagePath];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    // shelf tableView
    VoiceShelfViewController* shelf = [[VoiceShelfViewController alloc] initWithNibName:@"VoiceShelfViewController" bundle:nil];
    [self.view addSubview:shelf.view];
    
    // shadowView
    UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 53 )];
    shadowView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    NSString* shadowImageName = @"bookshelf_titlebar_shadow.png";
    NSString* shadowPath = [NSString stringWithFormat:@"%@/%@", resourcePath, shadowImageName];
    UIImage* shadowimage = [UIImage imageWithContentsOfFile:shadowPath];
    shadowView.backgroundColor = [UIColor colorWithPatternImage:shadowimage];
    [self.view addSubview:shadowView];
    [shadowView release];
    
    
     //[self.navigationController.navigationBar sendSubviewToBack:naviagationBackView];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:VALUE_TITLEBAR_COLOR_R green:VALUE_TITLEBAR_COLOR_G blue:VALUE_TITLEBAR_COLOR_B alpha:1.0];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)addTitleBarBackground
{
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    NSArray* sub = [self.navigationController.navigationBar subviews];
    if ([sub count] > 0) {
        UIView* naviagationBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height )];
        naviagationBackView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        NSString* navigationImageName = @"bg_shelf_titlebar.png";
        NSString* navigationPath = [NSString stringWithFormat:@"%@/%@", resourcePath, navigationImageName];
        UIImage* navigationimage = [UIImage imageWithContentsOfFile:navigationPath];
        naviagationBackView.backgroundColor = [UIColor colorWithPatternImage:navigationimage];
        [self.navigationController.navigationBar insertSubview:naviagationBackView atIndex:1];
    }
}

- (void)gotoStore
{
    StoreViewController* store = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:store];
    
    UIViewAnimationTransition transition = UIViewAnimationTransitionFlipFromRight;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:transition forView:[self.view window] cache: NO];
    [self presentModalViewController:nav animated:NO];
    [UIView commitAnimations];
    
    //CATransition *
    [store release];
    [nav release];
}

- (void)gotoSetting
{
    
}
@end
