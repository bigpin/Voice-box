//
//  main.m
//  Sanger
//
//  Created by JiaLi on 12-7-14.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SangerAppDelegate.h"
#import "MobiSageSDK.h"
int main(int argc, char *argv[])
{
    /*NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;*/
    @autoreleasepool {
        [[MobiSageManager getInstance] setPublisherID:@"0d7377403b9044a7938a54f751f0cfc5"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SangerAppDelegate class]));
    }
}
