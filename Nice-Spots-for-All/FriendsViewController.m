//
//  FriendsViewController.m
//  Nice-Spots-for-All
//
//  Created by Joshua on 12/4/14.
//  Copyright (c) 2014 joshclick. All rights reserved.
//

#import "FriendsViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "DBManager.h"

@interface FriendsViewController ()
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrFriends;
@property (nonatomic, strong) NSArray *dbFriends;
@end


@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _dbManager = [[DBManager alloc] initWithDatabaseFilename:@"nsa.sql"];
    
    NSString *query = @"select * from friends";
    
    // Get the results.
    if (_dbFriends != nil) {
        _dbFriends = nil;
    }
    _dbFriends = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    _tblFriends.delegate = self;
    _tblFriends.dataSource = self;
    _tblFriends.allowsMultipleSelection = YES;

    [FBRequestConnection startForMyFriendsWithCompletionHandler:
     ^(FBRequestConnection *connection, id<FBGraphUser> friends, NSError *error)
     {
         if (!error) {
             _arrFriends = [friends objectForKey:@"data"];
             NSLog(@"%@", _arrFriends);
             [_tblFriends reloadData];
         }
     }
     ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.textLabel.text = [_arrFriends[indexPath.row] objectForKey:@"name"];
    cell.tag = (int)[_arrFriends[indexPath.row] objectForKey:@"id"];
    
    
    NSInteger indexOfUid = [_dbManager.arrColumnNames indexOfObject:@"uid"];
    NSInteger indexOfStatus = [_dbManager.arrColumnNames indexOfObject:@"status"];
    
    void *status = NULL;
    for (int i = 0; i < [_dbFriends count]; i++) {
        int uid = (int)[[_dbFriends objectAtIndex:i] objectAtIndex:indexOfUid];
        status = (__bridge void *)([[_dbFriends objectAtIndex:i] objectAtIndex:indexOfStatus]);
        
        if (uid == cell.tag) {
            break;
        }
    }
    
    if (status == NULL || status == NO) {
        cell.accessoryView.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryView.hidden = NO;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView.hidden = NO;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [self setFriend:cell.tag andStatus:1];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView.hidden = YES;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [self setFriend:cell.tag andStatus:0];
}

- (void)setFriend:(int)uid andStatus:(int)status
{
    // update or insert relation with friend
    NSString *query = [NSString stringWithFormat:@"insert into friends (uid, status) values(coalesce((select uid from friends where uid='%i'), '%i),'%i')", uid, uid, status];

    // Execute the query.
    [_dbManager executeQuery:query];

    // If the query was successfully executed then pop the view controller.
    if (_dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", _dbManager.affectedRows);
    } else {
        NSLog(@"Could not execute the query.");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
