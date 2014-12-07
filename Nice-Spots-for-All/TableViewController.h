//
//  TableViewController.h
//  Nice Spots for All
//
//  Created by Josh Click on 11/20/14.
//
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UITableView *tblLocations;

@end
