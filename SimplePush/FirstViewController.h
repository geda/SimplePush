//
//  FirstViewController.h
//  SimplePush
//
//  Created by David Gerber on 25.09.16.
//  Copyright © 2016 David Gerber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController {
    
    // MARK: Properties
    IBOutlet UITextView *deviceToken;
}

@property (nonatomic, retain) UITextView *deviceToken;
- (IBAction)copyToken:(id)sender;

@end

