//
//  VoiceDataCellView.h
//  Sanger
//
//  Created by JiaLi on 12-9-18.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSBookShelfCell.h"

typedef enum {
    WOOD_PART_1,
    WOOD_PART_2
}WoodPart;

@interface VoiceDataCellView : UIView <GSBookShelfCell> {
    UIImageView *_shelfImageView;
    UIImageView *_shelfImageViewLandscape;
    UIImageView *_woodImageView;
    UIImageView *_shadingImageView;
    
    UIImageView *_sideImageView_left;
    UIImageView *_sideImageView_right;
    
}

@property (nonatomic, strong) NSString *reuseIdentifier;

+ (UIImage *)shadingImage;
+ (UIImage *)woodImage;
+ (UIImage *)shelfImageProtrait;
+ (UIImage *)shelfImageLandscape;

@end
