//
//  VoicePkgShelfCell.h
//  Sanger
//
//  Created by JiaLi on 12-10-10.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoicePkgShelfCell : UIButton
{
    UIImageView *_bookCover;
    UILabel* _label;
    UIImageView* _shadowImageView;

}
@property (nonatomic, retain) IBOutlet UIImageView* pkgImageView;
@property (nonatomic, retain) IBOutlet UILabel* pkgTitle;
@property (nonatomic, assign) NSInteger index;

- (void)setBookCover:(UIImage*)im;
- (void)setText:(NSString*)text;

@end
