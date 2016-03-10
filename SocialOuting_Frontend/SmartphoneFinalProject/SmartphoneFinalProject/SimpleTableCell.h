//
//  SimpleTableCell.h
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/16/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
