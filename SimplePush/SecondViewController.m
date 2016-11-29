//
//  SecondViewController.m
//  SimplePush
//
//  Created by David Gerber on 25.09.16.
//  Copyright © 2016 David Gerber. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize notifications, tableView;


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[notifications objectForKey:@"notifications"] count];
}

-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *simpleIdentifier = @"simpleIdentier";
    
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleIdentifier];
        
        cell.detailTextLabel.font = [cell.textLabel.font fontWithSize:9];
        
        NSMutableArray *notifArray = [notifications objectForKey:@"notifications"];
        if (notifArray.count) {
            NSDictionary *pushDict =notifArray[indexPath.row];

            cell.textLabel.text =  [pushDict objectForKey:@"receiveDate"];
            cell.detailTextLabel.text =  [[pushDict objectForKey:@"aps"]objectForKey:@"alert"];
            
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *pushDict = [notifications objectForKey:@"notifications"][indexPath.row];
    
    NSString *title = [pushDict objectForKey:@"receiveDate"] ;
    NSString *message =[[pushDict objectForKey:@"aps"]description];
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    
    
    // Display Alert Message
    [messageAlert show];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)theTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        
       
        [[notifications objectForKey:@"notifications"] removeObjectAtIndex:indexPath.row];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate persistNotificationPlist:notifications];
        
        
        [theTableView reloadData]; // tell table to refresh now
    }
}
@end
