//
//  FirstViewController.m
//  SimplePush
//
//  Created by David Gerber on 25.09.16.
//  Copyright © 2016 David Gerber. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize deviceToken;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)copyToken:(id)sender {
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString: self.deviceToken.text];
}
@end
