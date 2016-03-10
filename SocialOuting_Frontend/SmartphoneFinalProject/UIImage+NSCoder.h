//
//  UIImage+NSCoder.h
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/17/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyExtensions)
- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;
@end
