//
//  SangerViewController.m
//  Sanger
//
//  Created by JiaLi on 12-7-14.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "SangerViewController.h"
#import "StoreViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SangerViewController ()

@end

@implementation SangerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem* storeItem = [[UIBarButtonItem alloc] initWithTitle:@"store" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoStore)];
    self.navigationItem.rightBarButtonItem = storeItem;
    [storeItem release];
    UIBarButtonItem* setting = [[UIBarButtonItem alloc] initWithTitle:@"setting" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoSetting)];
    self.navigationItem.leftBarButtonItem = setting;
    [setting release];
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

- (void)gotoStore
{
    StoreViewController* store = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:store];
    
    UIViewAnimationTransition transition = UIViewAnimationTransitionFlipFromLeft;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:transition forView:[nav.view window] cache: YES];
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
