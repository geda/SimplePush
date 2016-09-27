//
//  FirstViewController.h
//  SimplePush
//
//  Created by David Gerber on 25.09.16.
//  Copyright © 2016 David Gerber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface FirstViewController : UIViewController <MFMailComposeViewControllerDelegate>{
    
    // MARK: Properties
    IBOutlet UITextView *deviceToken;
    IBOutlet UITextField *email;
}
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (nonatomic, retain) UITextView *deviceToken;

- (IBAction)copyToken:(id)sender;
- (IBAction)sendEmail:(id)sender;

@end

