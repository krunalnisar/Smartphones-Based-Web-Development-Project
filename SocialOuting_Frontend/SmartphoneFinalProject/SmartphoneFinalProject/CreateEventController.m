//
//  CreateEventController.m
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/14/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import "CreateEventController.h"
#import "Event.h"

@interface CreateEventController ()

@end

@implementation CreateEventController
@synthesize name,detailDescription,location,category,currentDate,user;
- (void)viewDidLoad {
    [super viewDidLoad];
    
     NSLog(user.name);
    self.title = @"Create Event";
    status = FALSE;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createEventButton:(id)sender {
    
    if([name.text isEqualToString:@""] || [detailDescription.text isEqualToString:@""] || [location.text isEqualToString:@""] ){
        [self alertStatus:@"Kindly Provide all the details" :@"Error"];
    }
    else{
        
    
    Event *event = [[Event alloc]init];
    event.name = name.text;
    event.detailDescription = detailDescription.text;
    event.location = location.text;
    
    if(category.selectedSegmentIndex == 0){
        event.category = @"Indoor";
    }
    else if (category.selectedSegmentIndex == 1){
        event.category = @"Outdoor";
    }
    else if (category.selectedSegmentIndex == 2){
        event.category = @"Adventure";
    }
    else if (category.selectedSegmentIndex == 3){
        event.category = @"Meetup";
    }
    NSDate *tempDate = [currentDate date];
    NSString *newDate = [[NSString alloc]initWithFormat:@"%@",tempDate];
    event.eventDate = newDate;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:event.name,@"name",event.detailDescription, @"detailDescription",event.location,@"location",event.category,@"category", event.eventDate,@"date",user.name,@"username", nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:nil error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/controller/createEvent"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:[NSString stringWithFormat:@"%ul",(unsigned)[data length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:data];
    
    NSHTTPURLResponse *response = nil;
    NSData *results = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *resultString = [[NSString alloc]initWithData:results encoding:NSUTF8StringEncoding];
    NSLog(@"%@",resultString);
    [user.eventList addObject:event];
        status = TRUE;
    [self alertStatus:@"Success" :@"Event Registered Successfully"];
    
    }
}


- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
