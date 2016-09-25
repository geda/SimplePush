//
//  SecondViewController.m
//  SimplePush
//
//  Created by David Gerber on 25.09.16.
//  Copyright © 2016 David Gerber. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.notifications = @[@"Alpha"];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.notifications count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *simpleIdentifier = @"simpleIdentier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleIdentifier];
        cell.textLabel.text = self.notifications[indexPath.row];
    }
    return cell;
}
@end
