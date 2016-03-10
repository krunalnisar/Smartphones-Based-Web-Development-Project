//
//  UIImage+NSCoder.m
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/17/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import "UIImage+NSCoder.h"

@implementation UIImage (MyExtensions)

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeDataObject:UIImagePNGRepresentation(self)];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    return [self initWithData:[decoder decodeDataObject]];
}

@end
