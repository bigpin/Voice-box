//
//  StoreViewController.m
//  Sanger
//
//  Created by JiaLi on 12-7-14.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "StoreViewController.h"
#import "GTMHTTPFetcher.h"
#import "StoreVoiceDataListParser.h"
#import "StoreRootViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

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
    
    self.title = STRING_DATA_CENTER;
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem* box = [[UIBarButtonItem alloc] initWithTitle:STRING_MY_DATA_CENTER style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = box;
    [box release];

    NSURL* url = [NSURL URLWithString:@"http://hd2002105.ourhost.cn/index_android.xml"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"MyApp" forHTTPHeaderField:@"User-Agent"];
    
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher beginFetchWithDelegate:self
                  didFinishSelector:@selector(fetcher:finishedWithData:error:)];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)back
{
    UIViewAnimationTransition trans = UIViewAnimationTransitionFlipFromRight;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition: trans forView:[self.view window] cache: NO];
    [self dismissModalViewControllerAnimated:NO];
    [UIView commitAnimations];
}


- (void)fetcher:(GTMHTTPFetcher*)fecther finishedWithData:(NSData*)data error:(id)error
{
    NSLog(@"fecther : %@", [fecther description]);
    NSLog(@"error : %@", [error description]);
    NSString* xmlPath =  [NSString stringWithFormat:@"%@voice.xml", NSTemporaryDirectory()];
    [data writeToFile:xmlPath atomically:YES];
    StoreVoiceDataListParser * dataParser = [[StoreVoiceDataListParser alloc] init];
    [dataParser loadWithData:data];
    if ([dataParser.pkgsArray count] > 0) {
        StoreRootViewController* rootViewController = [[StoreRootViewController alloc] init];
        rootViewController.pkgArray = dataParser.pkgsArray;
        [self.view addSubview:rootViewController.view];
    }
    [dataParser release];
}

@end
