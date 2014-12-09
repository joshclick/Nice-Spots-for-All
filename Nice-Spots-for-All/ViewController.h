//
//  ViewController.h
//  Nice-Spots-for-All
//
//
//  Created by Abhijai on 12/4/14.
//  Copyright (c) 2014 abhijaigarg. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController <FBLoginViewDelegate>


@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;

@end
