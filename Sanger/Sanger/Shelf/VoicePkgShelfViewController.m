//
//  VoicePkgShelfViewController.m
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "VoicePkgShelfViewController.h"
@interface VoicePkgShelfViewController ()

@end

@implementation VoicePkgShelfViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    VoicePkgTableViewController* pkgTable = [[VoicePkgTableViewController alloc] init];
    pkgTable.delegate = (id)self.delegate;
    [self.view addSubview:pkgTable.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
