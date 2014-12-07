//
//  TableViewController.m
//  Nice Spots for All
//
//  Created by Josh Click on 11/20/14.
//
//

#import "TableViewController.h"
#import "SWRevealViewController.h"
#import "DBManager.h"

@interface TableViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrLocations;

-(void)loadData;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _tblLocations.delegate = self;
    _tblLocations.dataSource = self;
    
    _dbManager = [[DBManager alloc] initWithDatabaseFilename:@"locations.sql"];

    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from locations";
    
    // Get the results.
    if (_arrLocations != nil) {
        _arrLocations = nil;
    }
    _arrLocations = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [_tblLocations reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _arrLocations.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfName = [self.dbManager.arrColumnNames indexOfObject:@"name"];
    NSInteger indexOfLat = [self.dbManager.arrColumnNames indexOfObject:@"lat"];
    NSInteger indexOfLong = [self.dbManager.arrColumnNames indexOfObject:@"long"];
    
    // Set the loaded data to the appropriate cell labels.
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrLocations objectAtIndex:indexPath.row] objectAtIndex:indexOfName]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lat: %@, Long: %@", [[self.arrLocations objectAtIndex:indexPath.row] objectAtIndex:indexOfLat], [[self.arrLocations objectAtIndex:indexPath.row] objectAtIndex:indexOfLong]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

@end
