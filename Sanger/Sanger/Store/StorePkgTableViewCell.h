//
//  StorePkgTableViewCell.h
//  Sanger
//
//  Created by JiaLi on 12-9-19.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMHTTPFetcher.h"
#import "StoreVoiceDataListParser.h"
@interface CustomBackgroundView : UIView {
    
}

@end

@interface StorePkgTableViewCell : UITableViewCell
{
    DataPkgInfo* _info;
}
@property (nonatomic, retain) IBOutlet UIImageView* coverImageView;
@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UILabel* introLabel;

- (void)setVoiceData:(DataPkgInfo*)info;
@end
