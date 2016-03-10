//
//  Common.m
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/15/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import "Common.h"

@implementation Common

- (void)saveImage: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithString: @"test.png"] ];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}
@end
