//
//  RegisterViewController.h
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/13/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface RegisterViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    BOOL status;
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextView *detailDescription;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UISwitch *adventureSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *meetupSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *indoorSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *outdoorSwitch;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(retain,nonatomic) User *user;
@end
