//
//  FriendsViewController.h
//  Nice-Spots-for-All
//
//  Created by Joshua on 12/4/14.
//  Copyright (c) 2014 joshclick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tblFriends;
@end
