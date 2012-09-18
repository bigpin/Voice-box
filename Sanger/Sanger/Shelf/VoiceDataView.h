//
//  VoiceDataView.h
//  Sanger
//
//  Created by JiaLi on 12-9-18.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSBookView.h"

@interface VoiceDataView : UIButton <GSBookView> {
    UIImageView *_checkedImageView;
    UIImageView* _shadowImageView;
    UIImageView *_bookCover;
    UILabel* _label;
}

@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) NSInteger index;

- (void)setBookCover:(UIImage*)im;
- (void)setText:(NSString*)text;
@end
