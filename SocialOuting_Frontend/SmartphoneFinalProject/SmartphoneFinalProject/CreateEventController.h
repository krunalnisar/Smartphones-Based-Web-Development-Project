//
//  CreateEventController.h
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/14/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CreateEventController : UIViewController{
    BOOL status;
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *detailDescription;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UISegmentedControl *category;
@property (weak, nonatomic) IBOutlet UIDatePicker *currentDate;

@property(strong,nonatomic)User *user;

@end
