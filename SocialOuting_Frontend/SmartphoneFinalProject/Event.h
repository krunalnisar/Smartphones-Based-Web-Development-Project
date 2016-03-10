//
//  Event.h
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/14/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject{
    NSString *name;
    NSString *detailDescription;
    NSString *location;
    NSString *category;
    NSString *eventDate;
    NSMutableArray *commentList;
}
@property NSString *name;
@property NSString *detailDescription;
@property NSString *location;
@property NSString *category;
@property NSString *eventDate;
@property NSMutableArray *commentList;
@end
