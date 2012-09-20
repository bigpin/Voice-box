//
//  StorePkgDetailViewController.m
//  Sanger
//
//  Created by JiaLi on 12-9-20.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "StorePkgDetailViewController.h"
#import "StorePkgDetailTableViewCell.h"

@interface StorePkgDetailViewController ()

@end

@implementation StorePkgDetailViewController
@synthesize info;

+ (CGSize)calcTextHeight:(NSString *)str withWidth:(CGFloat)width withFontSize:(CGFloat)fontSize;
{
    
    CGSize textSize = {width, 20000.0};
    CGSize size     = [str sizeWithFont:[UIFont systemFontOfSize:fontSize]
                      constrainedToSize:textSize];
    
    return size;
}

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
    self.title = self.info.title;
    self.tableView.separatorColor = [UIColor clearColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (self.info != nil) {
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.info.dataPkgCourseInfoArray.count + 1;
    } else {
        return 0;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger section = indexPath.section;
    NSInteger row =  indexPath.row;
    CGFloat height = 44.0f;
   if (section == 0) {
        return 114.0f;
    } else if (section == 1) {
        if (row == 0) {
            CGSize sz = [StorePkgDetailViewController calcTextHeight:info.intro withWidth:self.view.frame.size.width withFontSize:17];
            return fmaxf(height, (sz.height + 44));
        } else {
            NSInteger i = row - 1;
            if (i < [self.info.dataPkgCourseInfoArray count] ) {
                DataPkgCourseInfo* course = [self.info.dataPkgCourseInfoArray objectAtIndex:i];
                CGSize sz = [StorePkgDetailViewController calcTextHeight:course.title withWidth:self.view.frame.size.width withFontSize:17];
                return fmaxf(height, sz.height);
            }
        }

        return 44.0f;
    } else {
        return 44.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSInteger section = indexPath.section;
    NSInteger row =  indexPath.row;
    
    if (!cell) {
        if (section == 0) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"StorePkgDetailTableViewCell" owner:self options:NULL];
            if ([array count] > 0) {
                cell = [array objectAtIndex:0];
            }
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell"];
        }
     }
    
    if (section == 0) {
        StorePkgDetailTableViewCell * detailCell = (StorePkgDetailTableViewCell*)cell;
        [detailCell setVoiceData:info];
    } else {
        [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
        cell.textLabel.numberOfLines = 0;
        if (row == 0) {
            cell.textLabel.text = info.intro;
        } else {
            NSInteger i = row - 1;
            if (i < [self.info.dataPkgCourseInfoArray count] ) {
                DataPkgCourseInfo* course = [self.info.dataPkgCourseInfoArray objectAtIndex:i];
                cell.textLabel.text = course.title;
            }
        }
    }
    
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

- (void)dealloc
{
    [self.info release];
    [super dealloc];
}

@end
