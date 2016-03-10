//
//  FriendProfileController.h
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/17/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface FriendProfileController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextView *interestList;

@property NSString *username;
@property User *user;
@property User *mainUser;
@end
