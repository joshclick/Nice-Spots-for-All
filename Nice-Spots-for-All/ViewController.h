//
//  ViewController.h
//  Nice-Spots-for-All
//
//
//  Created by Joshua on 12/4/14.
//  Copyright (c) 2014 joshclick. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController <FBLoginViewDelegate>


@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;

@end
