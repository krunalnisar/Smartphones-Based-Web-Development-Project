//
//  FriendProfileController.m
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/17/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import "FriendProfileController.h"

@interface FriendProfileController ()

@end

@implementation FriendProfileController
@synthesize nameLabel,descriptionLabel,genderLabel,username,user,profileImage,interestList,mainUser;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUser];
    NSLog(mainUser.name);
    NSMutableString *title;
    title = [NSMutableString stringWithString:user.name];
    title = [NSMutableString stringWithString:@"Profile"];
    self.title = title;
    nameLabel.text = user.name;
    descriptionLabel.text = user.detailDescription;
    genderLabel.text = user.gender;
    interestList.text = user.interestList;
    //descriptionLabel.text
    profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
    profileImage.clipsToBounds = YES;
    profileImage.layer.borderWidth = 3.0f;
    profileImage.layer.borderColor = [UIColor whiteColor].CGColor;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadUser{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:username,@"name",nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:nil error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/controller/loadUser"];
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
            user = [[User alloc]init];
            user.name = [objects objectForKey:@"name"];
            user.detailDescription = [objects objectForKey:@"detailDescription"];
            user.gender = [objects objectForKey:@"gender"];
            user.interestList = [objects objectForKey:@"interestList"];
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:user.name ofType:@"jpg"];
            profileImage.image = [UIImage imageWithContentsOfFile:imagePath];
            }
        }
}
- (IBAction)addContact:(id)sender {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:username,@"contactName",mainUser.name,@"username",nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:nil error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/controller/addContact"];
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
    [self alertStatus:@"Added to your friend List" :@"Successful"];
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
@end
