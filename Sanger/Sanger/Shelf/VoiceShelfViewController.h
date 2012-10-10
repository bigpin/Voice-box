//
//  VoiceShelfViewController.h
//  Sanger
//
//  Created by JiaLi on 12-9-18.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSBookShelfView.h"
#import "BelowBottomView.h"
typedef enum {
    BOOK_UNSELECTED,
    BOOK_SELECTED
}BookStatus;

@interface VoiceDataPkg : NSObject

@property (nonatomic, retain) NSString* dataPath;
@property (nonatomic, retain) NSString* dataTitle;
@property (nonatomic, retain) NSString* dataCover;
@property (nonatomic, retain) NSNumber* dataNumber;
@end
@protocol VoiceShelfViewControllerDelegate <NSObject>

- (void)openVoiceData:(UIViewController*)controller;

@end

@interface VoiceShelfViewController : UIViewController <GSBookShelfViewDelegate, GSBookShelfViewDataSource>{
    GSBookShelfView *_bookShelfView;
    
    NSMutableArray *_bookArray;
    NSMutableArray *_bookStatus;
    
    NSMutableIndexSet *_booksIndexsToBeRemoved;
    
    BOOL _editMode;
    
    UIBarButtonItem *_editBarButton;
    UIBarButtonItem *_cancleBarButton;
    UIBarButtonItem *_trashBarButton;
    UIBarButtonItem *_addBarButton;
    
    BelowBottomView *_belowBottomView;
    UISearchBar *_searchBar;
}

@property (nonatomic, assign, readwrite) id <VoiceShelfViewControllerDelegate> delegate;

- (void)checkPkgData;

@end
