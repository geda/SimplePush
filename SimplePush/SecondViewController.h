//
//  SecondViewController.h
//  SimplePush
//
//  Created by David Gerber on 25.09.16.
//  Copyright © 2016 David Gerber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
   
    IBOutlet UITableView *tableView;
}


@property (retain, nonatomic) NSMutableDictionary *notifications;
@property (retain, nonatomic) UITableView *tableView;


@end

