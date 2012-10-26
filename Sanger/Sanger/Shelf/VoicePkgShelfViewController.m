//
//  VoicePkgShelfViewController.m
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "VoicePkgShelfViewController.h"
#import "GTMHTTPFetcher.h"
#import "StoreVoiceDataListParser.h"
#import "VoicePkgInfoObject.h"

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
    if (_pkgTable == nil) {
        VoicePkgTableViewController* pkgTable = [[VoicePkgTableViewController alloc] init];
        
        pkgTable.delegate = (id)self.delegate;
        [self.view addSubview:pkgTable.view];
        pkgTable.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
         _pkgTable = pkgTable;
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(addNewPkg:) name:NOTIFICATION_DOWNLOADED_VOICE_PKGXML object:nil];
       
        // download voice.xml
        NSURL* url = [NSURL URLWithString:STRING_STORE_URL_ADDRESS];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setValue:@"MyApp" forHTTPHeaderField:@"User-Agent"];
        
        GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
        [fetcher beginFetchWithDelegate:self
                      didFinishSelector:@selector(fetcher:finishedWithData:error:)];
        
   }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadPkgShelf;
{
    if (_pkgTable != nil) {
        [_pkgTable reloadPkgTable];
    }
}

- (void)addNewPkg:(id)object;
{
    if (_pkgTable != nil) {
        [_pkgTable reloadPkgTable];
    }
}

- (void)fetcher:(GTMHTTPFetcher*)fecther finishedWithData:(NSData*)data error:(id)error
{
    V_NSLog(@"fecther : %@", [fecther description]);
    V_NSLog(@"error : %@", [error description]);
    if (error != nil) {
        
    } else {
 
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        if (![fm fileExistsAtPath:documentDirectory isDirectory:nil])
            [fm createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        
        documentDirectory = [documentDirectory stringByAppendingFormat:@"/%@", STRING_VOICE_PKG_DIR];
        
        // create pkg
        if (![fm fileExistsAtPath:documentDirectory isDirectory:nil])
            [fm createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        
        
        NSString* xmlPath =  [NSString stringWithFormat:@"%@/voice.xml", documentDirectory];
        [data writeToFile:xmlPath atomically:YES];
        StoreVoiceDataListParser * dataParser = [[StoreVoiceDataListParser alloc] init];
        [dataParser loadWithData:data];
        DownloadServerInfo* info = [DownloadServerInfo sharedDownloadServerInfo];
        if (info != nil) {
            info.serverList = dataParser.serverlistArray;
        }
        [dataParser release];
    }
}

@end
