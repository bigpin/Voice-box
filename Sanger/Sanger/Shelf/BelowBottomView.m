//
//  BelowBottomView.m
//  Sanger
//
//  Created by JiaLi on 12-9-18.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import "BelowBottomView.h"
#import "VoiceDataCellView.h"

@implementation BelowBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        VoiceDataCellView *cell1 = [[VoiceDataCellView alloc] initWithFrame:CGRectMake(0, 0, 320, 139)];
        VoiceDataCellView *cell2 = [[VoiceDataCellView alloc] initWithFrame:CGRectMake(0, 139, 320, 139)];
        
        [cell1 setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [cell2 setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        
        [self addSubview:cell1];
        [self addSubview:cell2];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
