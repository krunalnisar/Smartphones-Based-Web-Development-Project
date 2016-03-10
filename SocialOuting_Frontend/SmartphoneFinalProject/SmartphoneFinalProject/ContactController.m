//
//  ContactController.m
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/18/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import "ContactController.h"

@interface ContactController ()

@end

@implementation ContactController{
    NSMutableArray *contactList;
}
@synthesize user;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Friend List";
    [self loadUser];
    NSLog(user.name);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return contactList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"contactCell";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 if (cell == nil) {
 
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
 
 }
    cell.textLabel.text = [contactList objectAtIndex:indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)loadUser{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:user.name,@"username",nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:nil error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/controller/loadContact"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:[NSString stringWithFormat:@"%ul",(unsigned)[data length]] forHTTPHeaderField:@"Content-length"];
    [request setHTTPBody:data];
    
    NSHTTPURLResponse *response = nil;
    NSData *results = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    // NSString *resultString = [[NSString alloc]initWithData:results encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",resultString);
    
    if([response statusCode] >= 200 && [response statusCode]< 300){
        NSString *responseData = [[NSString alloc]initWithData:results encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", responseData);
        
        NSError *error = nil;
        NSDictionary *jsonData = [NSJSONSerialization
                                  JSONObjectWithData:results
                                  options:NSJSONReadingMutableContainers
                                  error:&error];
        id objects = [NSJSONSerialization JSONObjectWithData:results options:nil error:nil];
        if(objects){
            contactList = [[NSMutableArray alloc]init];
            for(NSDictionary *dict in jsonData){
                [contactList addObject:[dict objectForKey:@"contactName"]];
            }
        }
    }
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self loadUser];
    
}

@end
