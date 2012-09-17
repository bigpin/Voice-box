//
//  main.m
//  Sanger
//
//  Created by JiaLi on 12-7-14.
//  Copyright (c) 2012年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SangerAppDelegate.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
    /*
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SangerAppDelegate class]));
    }*/
}
