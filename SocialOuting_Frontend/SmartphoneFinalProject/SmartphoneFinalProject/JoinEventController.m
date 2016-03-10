//
//  JoinEventController.m
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/15/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import "JoinEventController.h"
#import "FriendProfileController.h"
@interface JoinEventController ()

@end

@implementation JoinEventController{
    NSMutableArray *joinEvent;
    NSMutableArray *commentList;
}
@synthesize detailDescription,category,location,eventDate,event,user,persontableView,commentTableView,commentTextBox;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = event.name;
    [self listOfPersons];
    
    detailDescription.text = event.detailDescription;
    category.text = event.category;
    location.text = event.location;
    eventDate.text = event.eventDate;
    
    //commentList = [[NSMutableArray alloc]init];
    commentList = event.commentList;
    //tableView.dataSource = self;
    //commentTableView.dataSource =self;
    
    }


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if([tableView isEqual:persontableView]){
        return joinEvent.count;
    }
    else if([tableView isEqual:commentTableView]){
        return commentList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if([tableView isEqual:persontableView]){
        static NSString *simpleTableIdentifier = @"personCell";
        
         cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            
        }
        cell.textLabel.text = [joinEvent objectAtIndex:indexPath.row];
    }
    else if([tableView isEqual:commentTableView]){
        static NSString *simpleTableIdentifier = @"commentCell";
        
         cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            
        }
        cell.textLabel.text = [commentList objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"viewProfileCell"]){
        FriendProfileController *fpc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.persontableView indexPathForSelectedRow];
        fpc.username = [joinEvent objectAtIndex:indexPath.row];
        fpc.mainUser = user;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)joinEventButton:(id)sender {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:user.name,@"username",event.name,@"eventName",nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:nil error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/controller/joinEvent"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:[NSString stringWithFormat:@"%ul",(unsigned)[data length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:data];
    
    NSURLResponse *response = nil;
    NSData *results = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *resultString = [[NSString alloc]initWithData:results encoding:NSUTF8StringEncoding];
    //id objects = [NSJSONSerialization JSONObjectWithData:results options:nil error:nil];
    NSLog(@"%@",resultString);
    [self alertStatus:@"you have join the event successfully" :@"Done"];
    [self.persontableView reloadData];

}

-(void) listOfPersons{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:event.name,@"name",nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:nil error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/controller/eventDetails"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:[NSString stringWithFormat:@"%ul",(unsigned)[data length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:data];
    
    NSHTTPURLResponse *response = nil;
    NSData *results = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *resultString = [[NSString alloc]initWithData:results encoding:NSUTF8StringEncoding];
    //id objects = [NSJSONSerialization JSONObjectWithData:results options:nil error:nil];
    NSLog(@"%@",resultString);
    
    if([response statusCode] >= 200 && [response statusCode]< 300){
        NSString *responseData = [[NSString alloc]initWithData:results encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        NSError *error = nil;
        NSDictionary *jsonData = [NSJSONSerialization
                                  JSONObjectWithData:results
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
        id objects = [NSJSONSerialization JSONObjectWithData:results options:nil error:nil];
        joinEvent = [[NSMutableArray alloc]init];
        //NSArray *values = [objects objectForKey:@"eventList"];
        for(NSDictionary *dict in jsonData){
            Event *event = [[Event alloc]init];
            NSString *username = [dict objectForKey:@"username"];
            [joinEvent addObject:username];
            
        }
    }


}
- (IBAction)addCommentButton:(id)sender {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:event.name,@"eventName",commentTextBox.text,@"comment",user.name,@"username", nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:nil error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/controller/commentOnEvent"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:[NSString stringWithFormat:@"%ul",(unsigned)[data length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:data];
    
    NSHTTPURLResponse *response = nil;
    NSData *results = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *resultString = [[NSString alloc]initWithData:results encoding:NSUTF8StringEncoding];
    //id objects = [NSJSONSerialization JSONObjectWithData:results options:nil error:nil];
    NSLog(@"%@",resultString);
    
    if([response statusCode] >= 200 && [response statusCode]< 300){
        NSString *responseData = [[NSString alloc]initWithData:results encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        NSError *error = nil;
        NSDictionary *jsonData = [NSJSONSerialization
                                  JSONObjectWithData:results
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
        id objects = [NSJSONSerialization JSONObjectWithData:results options:nil error:nil];
       // commentList = [[NSMutableArray alloc]init];
        //NSArray *values = [objects objectForKey:@"eventList"];
            NSDictionary *dict = [objects lastObject];
            NSString *lastComment = [dict objectForKey:@"comment"];
            NSString *username =  user.name;
            //NSString *commentFromDb = [dict objectForKey:@"comment"];
            NSString *comment = [[NSString alloc] initWithFormat:@"%@ : %@",username,lastComment];
            [commentList addObject:comment];
        
            [self alertStatus:@"Your comment posted successfully" :@"Successful"];
    }
    [commentTableView reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated{
   // [commentTableView reloadData];
    //[self listOfPersons];
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
