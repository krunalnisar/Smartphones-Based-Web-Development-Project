//
//  ContactBarController.m
//  SmartphoneFinalProject
//
//  Created by Nimesh Rajal on 12/18/15.
//  Copyright © 2015 KrunalNisar. All rights reserved.
//

#import "ContactBarController.h"

@interface ContactBarController ()

@end

@implementation ContactBarController{
    NSMutableArray *contactList;
}
@synthesize user;
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Friend List";
    [self loadUser];
    //NSLog(user.name);
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return contactList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel *contactLabel = (UILabel*)cell;
    [contactLabel setText:[contactList objectAtIndex:indexPath.row ]];
    //UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //recipeImageView.image = [UIImage imageNamed:[contactList objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
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
    [self.collectionView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [self loadUser];
    
}


@end
