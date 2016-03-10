//
//  JoinEventController.h
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/15/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "User.h"
@interface JoinEventController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *detailDescription;

@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *eventDate;
@property (weak, nonatomic) IBOutlet UITableView *persontableView;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextBox;

@property(strong,nonatomic)Event *event;
@property(strong,nonatomic)User *user;
@end
