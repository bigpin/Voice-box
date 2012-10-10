//
//  VoiceShelfViewController.m
//  Sanger
//
//  Created by JiaLi on 12-9-18.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "VoiceShelfViewController.h"
#import "VoiceDataView.h"
#import "VoiceDataCellView.h"
#import "ScenesCoverViewController.h"

#define CELL_HEIGHT 139.0f
@implementation VoiceDataPkg
@synthesize  dataPath;
@synthesize  dataTitle;
@synthesize  dataCover;
@synthesize dataNumber;

- (void)dealloc
{
    [self.dataPath release];
    [self.dataTitle release];
    [self.dataCover release];
    [self.dataNumber release];
    [super dealloc];
}
@end

@interface VoiceShelfViewController ()

@end

@implementation VoiceShelfViewController
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
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString* stringResource = @"bg_bookshelf.png";
    NSString* imagePath = [NSString stringWithFormat:@"%@/%@", resourcePath, stringResource];
    UIImage* bgImage = [UIImage imageWithContentsOfFile:imagePath];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    // Do any additional setup after loading the view from its nib.
    //[self initBarButtons];
    [self switchToNormalMode];
    
	[self initBooks];
    NSInteger nWidth = self.view.bounds.size.width;
    NSInteger nHeight = self.view.bounds.size.height;
    //AboveTopView *aboveTop = [[AboveTopView alloc] initWithFrame:CGRectMake(0, 0, 320, 164)];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(22, 0, nWidth - 44, 44)];
    if ([_searchBar.subviews count] > 0) {
        [[_searchBar.subviews objectAtIndex:0]removeFromSuperview];
    }
	_searchBar.backgroundColor = [UIColor clearColor];
    [_searchBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    _belowBottomView = [[BelowBottomView alloc] initWithFrame:CGRectMake(0, 0, nWidth, CELL_HEIGHT * 2)];
    [_belowBottomView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    _bookShelfView = [[GSBookShelfView alloc] initWithFrame:CGRectMake(0, 0, nWidth, nHeight)];
    [_bookShelfView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [_bookShelfView setDataSource:self];
    
    [self.view addSubview:_bookShelfView];
}

- (void)checkPkgData
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
    NSString* file = [dirEnum nextObject];
    while (file) {
        NSRange range = [file rangeOfString:@"/" options:NSBackwardsSearch];
        NSLog(@"%@", file);
        if (range.location != NSNotFound) {
            file = [dirEnum nextObject];
            continue;
        }
        
        if ([[file pathExtension] length] == 0) {
            if (_bookArray == nil) {
                _bookArray = [[NSMutableArray alloc] init];
            }
            VoiceDataPkg* pkg = [[VoiceDataPkg alloc] init];
            pkg.dataPath = [NSString stringWithFormat:@"%@/%@",documentDirectory, file];
            pkg.dataTitle = file;
            [pkg.dataTitle retain];
            [_bookArray addObject:pkg];
            [pkg release];
        }
        file = [dirEnum nextObject];
    }
    
     [array release];
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

- (void)initBooks {
    [self checkPkgData];
    NSInteger numberOfBooks = [_bookArray count];
    //_bookArray = [[NSMutableArray alloc] initWithCapacity:numberOfBooks];
    _bookStatus = [[NSMutableArray alloc] initWithCapacity:numberOfBooks];
    for (int i = 0; i < numberOfBooks; i++) {
        NSNumber *number = [NSNumber numberWithInt:i % 4 + 1];
        VoiceDataPkg* pkg = [_bookArray objectAtIndex:i];
        pkg.dataNumber = number;
        [_bookStatus addObject:[NSNumber numberWithInt:BOOK_UNSELECTED]];
    }
    
    _booksIndexsToBeRemoved = [NSMutableIndexSet indexSet];
}

- (void)initBarButtons {
    _editBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonClicked:)];
    _cancleBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancleButtonClicked:)];
    
    _trashBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashButtonClicked:)];
    _addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClicked:)];
}

- (void)switchToNormalMode {
    _editMode = NO;
    
    [self.navigationItem setLeftBarButtonItem:_editBarButton];
    [self.navigationItem setRightBarButtonItem:_addBarButton];
}

- (void)switchToEditMode {
    _editMode = YES;
    [_booksIndexsToBeRemoved removeAllIndexes];
    [self.navigationItem setLeftBarButtonItem:_cancleBarButton];
    [self.navigationItem setRightBarButtonItem:_trashBarButton];
    
    for (int i = 0; i < [_bookArray count]; i++) {
        [_bookStatus addObject:[NSNumber numberWithInt:BOOK_UNSELECTED]];
    }
    
    for (VoiceDataView *bookView in [_bookShelfView visibleBookViews]) {
        [bookView setSelected:NO];
    }
}

#pragma mark - View lifecycle

- (void)testScrollToRow {
    [_bookShelfView scrollToRow:34 animate:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"will rotate from %u to %u", [[UIDevice currentDevice] orientation], toInterfaceOrientation);
    // TODO:only set orientation change flag when protrait to landscape and reverse
    [_bookShelfView oritationChangeReloadData];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"will animate rotate");
    NSLog(@"bookShelfViewFrame:%@", NSStringFromCGRect(_bookShelfView.frame));
 }

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"didRotate");
    NSLog(@"bookShelfViewFrame:%@", NSStringFromCGRect(_bookShelfView.frame));
}

#pragma mark GSBookShelfViewDataSource

- (NSInteger)numberOfBooksInBookShelfView:(GSBookShelfView *)bookShelfView {
    return [_bookArray count];
}

- (NSInteger)numberOFBooksInCellOfBookShelfView:(GSBookShelfView *)bookShelfView {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(orientation)) {
        return 4;
    }
    else {
        return 3;
    }
}

- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView bookViewAtIndex:(NSInteger)index {
    static NSString *identifier = @"bookView";
    VoiceDataView *bookView = (VoiceDataView *)[bookShelfView dequeueReuseableBookViewWithIdentifier:identifier];
    if (bookView == nil) {
        bookView = [[VoiceDataView alloc] initWithFrame:CGRectZero];
        bookView.reuseIdentifier = identifier;
        [bookView addTarget:self action:@selector(bookViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [bookView setIndex:index];
    [bookView setSelected:[(NSNumber *)[_bookStatus objectAtIndex:index] intValue]];
    //int imageNO = [(NSNumber *)[_bookArray objectAtIndex:index] intValue];
    // set book cover
    //[bookView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"mask_book.png"]] forState:UIControlStateNormal];
    VoiceDataPkg* pkg = [_bookArray objectAtIndex:index];
    [bookView setBookCover:[UIImage imageWithContentsOfFile:pkg.dataCover]];
    [bookView setText:pkg.dataTitle];

    /*if (index == 0) {
        [bookView setBookCover:[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"chuguobibei.png"]]];
        [bookView setText:STRING_DATA_SAMPLE_1];

    } else {
        [bookView setBookCover:[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"zhichangyingyu"]]];
        [bookView setText:STRING_DATA_SAMPLE_2];
       
    }*/

    return bookView;
}

- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView cellForRow:(NSInteger)row {
    static NSString *identifier = @"cell";
    /*MyCellView *cellView = (MyCellView *)[bookShelfView dequeueReuseableCellViewWithIdentifier:identifier];
     if (cellView == nil) {
     cellView = [[MyCellView alloc] initWithFrame:CGRectZero];
     cellView.reuseIdentifier = identifier;
     [cellView.layer setBorderColor:[[UIColor redColor] CGColor]];
     [cellView.layer setBorderWidth:2.0f];
     }
     [cellView.label setText:[NSString stringWithFormat:@"row:%d", row]];
     return cellView;*/
    
    VoiceDataCellView *cellView = (VoiceDataCellView *)[bookShelfView dequeueReuseableCellViewWithIdentifier:identifier];
    if (cellView == nil) {
        cellView = [[VoiceDataCellView alloc] initWithFrame:CGRectZero];
        [cellView setReuseIdentifier:identifier];
        //[cellView.layer setBorderColor:[[UIColor redColor] CGColor]];
        //[cellView.layer setBorderWidth:2.0f];
    }
    return cellView;
}

- (UIView *)aboveTopViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return nil;
}

- (UIView *)belowBottomViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return _belowBottomView;
}

- (UIView *)headerViewOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return _searchBar;
}

- (CGFloat)cellHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return CELL_HEIGHT;
}

- (CGFloat)cellMarginOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 10.0f;
}

- (CGFloat)bookViewHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 126.0f;
}

- (CGFloat)bookViewWidthOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 98.0f;
}

- (CGFloat)bookViewBottomOffsetOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return 134.0f;
}

- (CGFloat)cellShadowHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    //return 0.0f;
    return 20.0f;
}

- (void)bookShelfView:(GSBookShelfView *)bookShelfView moveBookFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    return;
    if ([(NSNumber *)[_bookStatus objectAtIndex:fromIndex] intValue] == BOOK_SELECTED) {
        [_booksIndexsToBeRemoved removeIndex:fromIndex];
        [_booksIndexsToBeRemoved addIndex:toIndex];
    }
    
    [_bookArray moveObjectFromIndex:fromIndex toIndex:toIndex];
    [_bookStatus moveObjectFromIndex:fromIndex toIndex:toIndex];
    
    // the bookview is recognized by index in the demo, so change all the indexes of affected bookViews here
    // This is just a example, not a good one.In your code, you'd better use a key to recognize the bookView.
    // and you won't need to do the following
    VoiceDataView *bookView;
    bookView = (VoiceDataView *)[_bookShelfView bookViewAtIndex:toIndex];
    [bookView setIndex:toIndex];
    if (fromIndex <= toIndex) {
        for (int i = fromIndex; i < toIndex; i++) {
            bookView = (VoiceDataView *)[_bookShelfView bookViewAtIndex:i];
            [bookView setIndex:bookView.index - 1];
        }
    }
    else {
        for (int i = toIndex + 1; i <= fromIndex; i++) {
            bookView = (VoiceDataView *)[_bookShelfView bookViewAtIndex:i];
            [bookView setIndex:bookView.index + 1];
        }
    }
}

#pragma mark - BarButtonListener

- (void)editButtonClicked:(id)sender {
    [self switchToEditMode];
}

- (void)cancleButtonClicked:(id)sender {
    [self switchToNormalMode];
}

- (void)trashButtonClicked:(id)sender {
    [_bookArray removeObjectsAtIndexes:_booksIndexsToBeRemoved];
    [_bookStatus removeObjectsAtIndexes:_booksIndexsToBeRemoved];
    [_bookShelfView removeBookViewsAtIndexs:_booksIndexsToBeRemoved animate:YES];
    [self switchToNormalMode];
}

- (void)addButtonClicked:(id)sender {
    int a[6] = {1, 2, 5, 7, 9, 22};
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *stat = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        [indexSet addIndex:a[i]];
        [arr addObject:[NSNumber numberWithInt:1]];
        [stat addObject:[NSNumber numberWithInt:BOOK_UNSELECTED]];
    }
    [_bookArray insertObjects:arr atIndexes:indexSet];
    [_bookStatus insertObjects:stat atIndexes:indexSet];
    [_bookShelfView insertBookViewsAtIndexs:indexSet animate:YES];
}

#pragma mark - BookView Listener

- (void)bookViewClicked:(UIButton *)button {
    VoiceDataView *bookView = (VoiceDataView *)button;
    NSLog(@"click : %d",bookView.index);
    VoiceDataPkg* pkg = [_bookArray objectAtIndex:bookView.index];
    NSLog(@"click pkg: %@", pkg.dataTitle);
    NSLog(@"click pkg number: %d", [pkg.dataNumber intValue]);
 
    if (_editMode) {
        NSNumber *status = [NSNumber numberWithInt:bookView.selected];
        [_bookStatus replaceObjectAtIndex:bookView.index withObject:status];
        
        if (bookView.selected) {
            [_booksIndexsToBeRemoved addIndex:bookView.index];
        }
        else {
            [_booksIndexsToBeRemoved removeIndex:bookView.index];
        }
    }
    else {
        [bookView setSelected:NO];
        ScenesCoverViewController * scenes = [[ScenesCoverViewController alloc] init];
        scenes.dataPath = pkg.dataPath;
        scenes.dataTitle = pkg.dataTitle;
        [self.delegate openVoiceData:scenes];
        
    }
}



@end
