//
//  PhotoViewController.h
//  Nice-Spots-for-All
//
//  Created by Abhijai on 12/4/14.
//  Copyright (c) 2014 abhijaigarg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) NSString *photoFilename;
@end
