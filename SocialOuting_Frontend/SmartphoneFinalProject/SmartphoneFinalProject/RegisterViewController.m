//
//  RegisterViewController.m
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/13/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import "RegisterViewController.h"
#import "ViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize user,name,gender,detailDescription,username,password,indoorSwitch,outdoorSwitch,adventureSwitch,meetupSwitch,imageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    status = FALSE;
    self.title = @"Register";
    NSLog(user.detailDescription);    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)savePerson:(id)sender {
    
    if([name.text isEqualToString:@""] || [gender.text isEqualToString:@""] || [detailDescription.text isEqualToString:@""]
       || [username.text isEqualToString:@""] || [password.text isEqualToString:@""]){
        [self alertStatus:@"Kindly Provide all the details" :@"Error"];

    }
    else{
        
    
    user = [[User alloc]init];
    
    user.name = name.text;
    user.gender = gender.text;
    user.detailDescription = detailDescription.text;
    user.username = username.text;
    user.password = password.text;
    user.userImage = imageView.image;
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *imagePath = [[NSString alloc] initWithFormat:@"%@/%@",resourcePath,user.name];
    NSData* settingsData = UIImagePNGRepresentation(imageView.image);
    [settingsData writeToFile:imagePath atomically:YES];
    user.imagePath = imagePath;
    
    
    NSMutableString *interestList;
    if (indoorSwitch.on) {
        interestList = [NSMutableString stringWithString:@"Indoor,"];
    }
    else if (outdoorSwitch.on){
        interestList = [NSMutableString stringWithString:@"Outdoor,"];
    }else if (adventureSwitch.on){
        interestList = [NSMutableString stringWithString:@"Adventure,"];
    }else if (meetupSwitch.on){
        interestList = [NSMutableString stringWithString:@"Meetup"];
    }
    user.interestList = interestList;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:user.name,@"name",user.gender,@"gender", user.detailDescription,@"detailDescription", user.username,@"username",user.password,@"password",user.imagePath,@"imagePath",user.interestList,@"interestList", nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:nil error:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/controller/register"];
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
    
    if (resultString) {
        NSLog(@"%@",resultString);
        status = TRUE;
    }
    else{
        [self alertStatus:@"Registeration Failed" :@"Username already exist"];
    }

    
}
}
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ViewController *vc = [segue destinationViewController];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return status;
}
*/
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
- (IBAction)browseImageButton:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
   
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return status;
}

@end
