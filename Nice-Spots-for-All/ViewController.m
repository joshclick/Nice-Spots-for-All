//
//  ViewController.m
//   Nice-Spots-for-All
//
//
//  Created by Abhijai on 12/4/14.
//  Copyright (c) 2014 abhijaigarg. All rights reserved.
//


#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

-(void)toggleHiddenState:(BOOL)shouldHide;
@property (weak, nonatomic) IBOutlet FBLoginView *button;

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self toggleHiddenState:YES];
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"user_friends",@"public_profile", @"email"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private method implementation

-(void)toggleHiddenState:(BOOL)shouldHide{
}


#pragma mark - FBLoginView Delegate method implementation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    
    [self toggleHiddenState:NO];
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSLog(@"%@", user);
    
    //push new view controller
    
    [self performSegueWithIdentifier: @"Login" sender: self];
}


-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    [self toggleHiddenState:YES];
}


-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}


@end
