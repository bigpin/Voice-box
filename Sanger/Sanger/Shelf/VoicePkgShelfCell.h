//
//  VoicePkgShelfCell.h
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VoicePkgShelfCell;
@protocol VoicePkgShelfCellDelegete <NSObject>

- (void)deletePkg:(VoicePkgShelfCell*)cell;

@end
@interface VoicePkgShelfCell : UIView
{
    UIImageView *_bookCover;
    UILabel* _label;
    UIImageView* _shadowImageView;
    BOOL _bEdit;
    UIButton* _deleteButton;

}
@property (nonatomic, retain) IBOutlet UIImageView* pkgImageView;
@property (nonatomic, retain) IBOutlet UILabel* pkgTitle;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) id <VoicePkgShelfCellDelegete> delegate;

- (void)setBookCover:(UIImage*)im;
- (void)setText:(NSString*)text;
- (void)showEditBar:(BOOL)bShow;
@end
