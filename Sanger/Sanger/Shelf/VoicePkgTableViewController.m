//
//  VoicePkgTableViewController.m
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "VoicePkgTableViewController.h"
#import "ScenesCoverViewController.h"
#import "Database.h"


#define DEFAULT_TABLEVIEWHEITHT_IPHONE 116
#define DEFAULT_TABLEVIEWHEITHT_IPAD 220
#define DEFAULT_BOOKCOVERCOUNT	3

@interface VoicePkgTableViewController ()

@end

@implementation VoicePkgTableViewController
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *singleOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTappedBackground:)];
    singleOne.numberOfTouchesRequired = 1; // Touch count
    singleOne.numberOfTapsRequired = 1;    // tap count
    //singleOne.delegate = self;
    [self.view addGestureRecognizer:singleOne];
    [singleOne release];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 	self.tableView.rowHeight = IS_IPAD ? DEFAULT_TABLEVIEWHEITHT_IPAD : DEFAULT_TABLEVIEWHEITHT_IPHONE;
	NSInteger bookCoverWidth = IS_IPAD ? 83 :70;
	NSInteger bookCoverHeight = IS_IPAD ? 100 : 95;
    self.view.backgroundColor = [UIColor clearColor];
	szBookCover = CGSizeMake(bookCoverWidth, bookCoverHeight);
     if (IS_IPAD) {
        nCountPerRow = 4 ;
    } else {
        nCountPerRow = 3 ;
    }
	nDY = IS_IPAD ? 20 : 15;
    _bEdit = NO;
    [self loadPkgArray];
   // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_pkgArray count] == 0) {
        return 0;
    }
    
    return ([_pkgArray count] / 3) + 1;
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return szBookCover.height + 42;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSInteger nCount = [_pkgArray count];
	if ((nCount % nCountPerRow) == 0) {
		return nCount / nCountPerRow;
	} else {
		return ((nCount / nCountPerRow) + 1);
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		UIImageView* v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.tableView.rowHeight)];
		v.image = backgroundImage;
		cell.backgroundView = v;
		[v release];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
		while ([cell.contentView.subviews count] > 0) {
			UIView* subView = [[cell.contentView subviews] objectAtIndex:0];
			if (subView != nil) {
				[subView removeFromSuperview];
				subView = nil;
			}
		}
	}
    
	NSInteger nRow = indexPath.row;
	
	
	CGFloat dx = (self.view.bounds.size.width - nCountPerRow * szBookCover.width)/ (CGFloat)(nCountPerRow + 1);
	CGFloat dy = self.tableView.rowHeight - szBookCover.height;// - nDY;
	for (NSInteger i = 0; i < nCountPerRow; i ++) {
		NSInteger index = (nCountPerRow * nRow) + i;
		if (index < [_pkgArray count]) {
            VoicePkgShelfCell* cover = [[VoicePkgShelfCell alloc] initWithFrame:CGRectMake(i * szBookCover.width + (i + 1) * dx, dy, szBookCover.width, szBookCover.height)];
			[cell.contentView addSubview:cover];
            cover.index = index;
			VoiceDataPkgObject* pkg = [_pkgArray objectAtIndex:index];
            [cover setBookCover:[UIImage imageWithContentsOfFile:pkg.dataCover]];
            [cover setText:pkg.dataTitle];
            [cover showEditBar:_bEdit];
            cover.delegate = (id)self;
            [self addAction:cover];
			//[cover addTarget:self action:@selector(openSences:) forControlEvents:UIControlEventTouchDown];
			[cover release];
		}
		//[cover setImage:coverimage forState:UIControlStateNormal];
	}
    
    // Configure the cell...
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)loadPkgArray
{
    Database* db = [Database sharedDatabase];
    _pkgArray = [db loadVoicePkgInfo];
}

- (void)checkPkgfromFolder;
{
     NSFileManager *fm = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	if (![fm fileExistsAtPath:documentDirectory isDirectory:nil])
		[fm createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    documentDirectory = [documentDirectory stringByAppendingFormat:@"/%@", STRING_VOICE_PKG_DIR];
    
    // create pkg
    if (![fm fileExistsAtPath:documentDirectory isDirectory:nil])
        [fm createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:documentDirectory];
    [dirEnum skipDescendants];
    NSString* file = [dirEnum nextObject];
    while (file) {
        NSLog(@"%@", file);
        NSRange range = [file rangeOfString:@"/" options:NSBackwardsSearch];
          if (range.location != NSNotFound) {
            file = [dirEnum nextObject];
            continue;
        }
        
        if ([[file pathExtension] length] == 0) {
            if (_pkgArray == nil) {
                _pkgArray = [[NSMutableArray alloc] init];
            }
            VoiceDataPkgObject* pkg = [[VoiceDataPkgObject alloc] init];
            pkg.dataPath = [NSString stringWithFormat:@"%@/%@",documentDirectory, file];
            pkg.dataTitle = file;
             [_pkgArray addObject:pkg];
            [pkg release];
        }
        file = [dirEnum nextObject];
    }
    
    [array release];

}

- (void)openSences:(id)sender
{
    VoicePkgShelfCell* cover = (VoicePkgShelfCell*)sender;
    ScenesCoverViewController * scenes = [[ScenesCoverViewController alloc] init];
    NSInteger index = cover.index;
    if (index < [_pkgArray count]) {
        VoiceDataPkgObject* pkg = [_pkgArray objectAtIndex:index];
        scenes.dataPath = pkg.dataPath;
        scenes.dataTitle = pkg.dataTitle;
        [self.delegate openVoiceData:scenes];

    }
    
}

- (void)reloadPkgTable;
{
    UIInterfaceOrientation orientation = [self interfaceOrientation];
    if (IS_IPAD) {
        nCountPerRow = UIInterfaceOrientationIsPortrait(orientation) ? 4 :6;
    } else {
        nCountPerRow = UIInterfaceOrientationIsPortrait(orientation) ? 3 :4;

    }
    if (_pkgArray != nil) {
        [_pkgArray release];
        _pkgArray = nil;
        Database* db = [Database sharedDatabase];
        _pkgArray = [db loadVoicePkgInfo];
    }
    [self.tableView reloadData];
}

- (void)addAction:(VoicePkgShelfCell*)cell;
{
    UITapGestureRecognizer *singleOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    singleOne.numberOfTouchesRequired = 1; // Touch count
    singleOne.numberOfTapsRequired = 1;    // tap count
    //singleOne.delegate = self;
    [cell addGestureRecognizer:singleOne];
    [singleOne release];
    
    // Long tap
    UILongPressGestureRecognizer* longSingleTapRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    longSingleTapRecognizer.numberOfTouchesRequired = 1;
    [cell addGestureRecognizer:longSingleTapRecognizer];
    [longSingleTapRecognizer release];
}

- (void)singleTapped:(UITapGestureRecognizer*)recognizer
{
    if (!_bEdit) {
        VoicePkgShelfCell* cell = (VoicePkgShelfCell*)recognizer.view;
        [self openSences:cell];
    }
}

- (void)singleTappedBackground:(UITapGestureRecognizer*)recognizer
{
    if (_bEdit) {
        _bEdit = NO;
 		[[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_EDIT_VOICE_PKG object: [NSNumber numberWithBool:NO]];
    }
}

- (void)longPressed:(UILongPressGestureRecognizer*)recognizer
{
   // VoicePkgShelfCell* cell = (VoicePkgShelfCell*)recognizer.view;
    if (!_bEdit) {
        _bEdit = YES;
		[[NSNotificationCenter defaultCenter] postNotificationName: NOTIFICATION_EDIT_VOICE_PKG object: [NSNumber numberWithBool:YES]];
    }
}

- (void)deletePkg:(VoicePkgShelfCell*)cell;
{
    NSInteger index = cell.index;
    _deleteObject = [_pkgArray objectAtIndex:index];
	NSString *message = [NSString stringWithFormat:@"%@",STRING_DELETEBOOK_ALERT_MESSAGE];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:STRING_DELETEBOOK_ALERT_TITLE
													message:message
												   delegate:self
										  cancelButtonTitle:STRING_DELETEBOOK_BUTTON_CONFIRM otherButtonTitles:STRING_DELETEBOOK_BUTTON_CANCEL, nil];
	[alert show];
	[alert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        // confirm
        Database* db = [Database sharedDatabase];
        VoiceDataPkgObjectFullInfo* info = [db loadVoicePkgInfoByTitle:_deleteObject.dataTitle];
        if (info != nil) {
            NSFileManager* fm = [NSFileManager defaultManager];
            [fm removeItemAtPath:info.dataPath error:nil];
        }

        [db deleteVoicePkgInfoByTitle:_deleteObject.dataTitle];
        [self reloadPkgTable];
    } else {
        // cancel
    }
    _deleteObject = nil;

}
@end
