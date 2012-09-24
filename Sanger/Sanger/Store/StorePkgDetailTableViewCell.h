//
//  StorePkgDetailTableViewCell.h
//  Sanger
//
//  Created by JiaLi on 12-9-20.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreVoiceDataListParser.h"

@interface DetailCustomBackgroundView : UIView {
    
}

@end


@interface StorePkgDetailTableViewCell : UITableViewCell
{
    DataPkgInfo* _info;

}

@property (nonatomic, retain) IBOutlet UIImageView* coverImageView;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UIButton* downloadButton;

- (void)setVoiceData:(DataPkgInfo*)info;
- (void)setButtomImage;
@end
