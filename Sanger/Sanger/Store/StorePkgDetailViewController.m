//
//  StorePkgDetailViewController.m
//  Sanger
//
//  Created by JiaLi on 12-9-20.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "StorePkgDetailViewController.h"
#import "StorePkgDetailTableViewCell.h"
#import "StoreCourceTableViewCell.h"
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString* stringResource = @"bg_webview.png";
    NSString* imagePath = [NSString stringWithFormat:@"%@/%@", resourcePath, stringResource];
    UIImage* bgImage = [UIImage imageWithContentsOfFile:imagePath];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];

    /*NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString* stringResource = @"bg_cell.png";
    NSString* imagePath = [NSString stringWithFormat:@"%@/%@", resourcePath, stringResource];
    UIImage* bgImage = [UIImage imageWithContentsOfFile:imagePath];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    */
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
        return self.info.dataPkgCourseInfoArray.count + 3;
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
            // content text
            return 44.0f;
        } else if (row == 1) {
            // content
            CGSize sz = [StorePkgDetailViewController calcTextHeight:info.intro withWidth:self.view.frame.size.width withFontSize:17];
            return fmaxf(height, (sz.height + 22));
        } else if (row == 2){
            // lesson text
            return 44.0f;
        } else {
            // lessons 
            NSInteger i = row - 3;
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
            UIView* backgroundView = [[UIView alloc] initWithFrame:cell.frame];
            backgroundView.backgroundColor = [UIColor colorWithRed:VALUE_DETAIL_STORE_BACKGROUND_COLOR1_R green:VALUE_DETAIL_STORE_BACKGROUND_COLOR1_G blue:VALUE_DETAIL_STORE_BACKGROUND_COLOR1_B alpha:1.0];
            cell.backgroundView = backgroundView;
            [backgroundView release];
           
            
        } else {
            
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"StoreCourceTableViewCell" owner:self options:NULL];
            if ([array count] > 0) {
                cell = [array objectAtIndex:0];
            }

            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell"];
            if (row == 0) {
                DetailCustomBackgroundView* backgroundView = [[DetailCustomBackgroundView alloc] init];
                cell.backgroundView = backgroundView;
                [backgroundView release];
            } else {
                UIView* backgroundView = [[UIView alloc] initWithFrame:cell.frame];
                backgroundView.backgroundColor = [UIColor colorWithRed:VALUE_DETAIL_STORE_BACKGROUND_COLOR1_R green:VALUE_DETAIL_STORE_BACKGROUND_COLOR1_G blue:VALUE_DETAIL_STORE_BACKGROUND_COLOR1_B alpha:1.0];
                cell.backgroundView = backgroundView;
                [backgroundView release];
                
            }
       }

     }

    switch (section) {
        case 0:
        {
            StorePkgDetailTableViewCell * detailCell = (StorePkgDetailTableViewCell*)cell;
            [detailCell setVoiceData:info];

        }
            break;
        case 1:
        {
          switch (row) {
                case 0:
                {
                    cell.backgroundColor = [UIColor whiteColor];
                   cell.textLabel.text = STRING_INTRO_TITLE;
                    cell.textLabel.numberOfLines = 0;
                    [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
                    cell.textLabel.backgroundColor = [UIColor clearColor];
                    cell.textLabel.textColor = [UIColor darkGrayColor];
                   //cell.textLabel.textColor = [UIColor colorWithRed:105.0/255.0 green:128.0/255.0 blue:133.0/255.0 alpha:1.0];

                }
                    
                    break;
                case 1:
                {
                    cell.textLabel.text = info.intro;
                    cell.textLabel.numberOfLines = 0;
                    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
                    cell.textLabel.backgroundColor = [UIColor clearColor];
                    cell.textLabel.textColor = [UIColor darkGrayColor];
                   //cell.textLabel.textColor = [UIColor colorWithRed:121.0/255.0 green:132.0/255.0 blue:146.0/255.0 alpha:1.0];
               }
                    
                    break;
                case 2:
                {
                   // cell.textLabel.textColor = [UIColor colorWithRed:121.0/255.0 green:132.0/255.0 blue:146.0/255.0 alpha:1.0];
                   cell.textLabel.text = STRING_LESSONS_TITLE;
                    cell.textLabel.numberOfLines = 0;
                    [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
                    cell.textLabel.backgroundColor = [UIColor clearColor];
                    cell.textLabel.textColor = [UIColor darkGrayColor];
               }
                    break;
                default:
                {
                    NSInteger i = row - 3;
                    if (i < [self.info.dataPkgCourseInfoArray count] ) {
                        DataPkgCourseInfo* course = [self.info.dataPkgCourseInfoArray objectAtIndex:i];
                        cell.textLabel.text = course.title;
                        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
                        cell.textLabel.backgroundColor = [UIColor clearColor];
                        cell.textLabel.textColor = [UIColor darkGrayColor];
                        //StoreCourceTableViewCell * courseCell = (StoreCourceTableViewCell*)cell;
                        //[courseCell setCourseData:course withURL:self.info.url];
                  }
                    
                }
                    
                    break;
            }
            
        }
            
        break;
           default:
             break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.backgroundColor =  [UIColor colorWithRed:VALUE_DETAIL_STORE_BACKGROUND_COLOR2 green:VALUE_DETAIL_STORE_BACKGROUND_COLOR2 blue:VALUE_DETAIL_STORE_BACKGROUND_COLOR2 alpha:1.0];
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
