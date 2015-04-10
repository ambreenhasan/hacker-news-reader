//
//  TableViewController.m
//  HackerNewsReader
//
//  Created by Ambreen Hasan on 4/1/15.
//  Copyright (c) 2015 Ambreen Hasan. All rights reserved.
//

#import "TableViewController.h"
#import "BlogPost.h"
#import "WebViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSURL *topStoriesURL = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
    
    NSData  *jsonData = [NSData dataWithContentsOfURL:topStoriesURL];
    
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    self.blogPosts = [NSMutableArray array];
    
    NSArray *blogPostsArray = [dataDictionary objectForKey:@"posts"];
    
    for (NSDictionary *bpPost in blogPostsArray) {
        BlogPost *blogPost = [BlogPost blogPostWithTitle:[bpPost objectForKey:@"title"]];
        blogPost.author = [bpPost objectForKey:@"author"];
        blogPost.thumbnail = [bpPost objectForKey:@"thumbnail"];
        blogPost.date = [bpPost objectForKey:@"date"];
        blogPost.url = [NSURL URLWithString:[bpPost objectForKey:@"url"]];
        [self.blogPosts addObject:blogPost];
    }

    
    NSLog(@"%@", self.blogPosts);
    
    
//    self.blogPosts = [dataDictionary objectForKey:@"posts"];
    
    // Hacker News attempt
//    NSLog(@"%@", dataDictionary);
    
//    for (NSInteger index = 0; index < dataDictionary.count; index++) {
//        NSURL *storyInformationURL = [NSURL URLWithString:
//                                      [NSString stringWithFormat:@"",
//                                       dataDictionary[index]]];
//        
//        NSData  *jsonData = [NSData dataWithContentsOfURL:storyInformationURL];
//        
//        NSDictionary *hackerNewsDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
//        
//        NSLog(@"%@", hackerNewsDictionary);
//        
//    }
//    
//    self.blogPosts = [NSArray arrayWithObject:hackerNewsDictionary];
    
   
    
    
//    
//        NSLog(@"%@", hackerNewsDictionary);
//    
    
    
//    self.designSection = [NSArray arrayWithObjects: @"An Interview with Shay Howe",
//                   @"Getting a Job in Web Design and Development", nil];
//    
//    self.mobileSection = [NSArray arrayWithObjects:@"Get started with iOS Development",@"How to add Facebook authentication in Android", nil];
//    
//    self.developmentSection = [NSArray arrayWithObjects:@"Get started with Ruby on Rails", @"What is a template engine and how to use one.", nil];
//    
//    self.sections = [NSArray arrayWithObjects:self.designSection, self.mobileSection, self.developmentSection, nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.blogPosts count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
////    switch (section) {
////        case 0:
////            return @"Web Design";
////            break;
////        case 1:
////            return @"Mobile Development";
////            break;
////        case 2:
////            return @"Web Development";
////            break;
////        default:
////            return @"No section could be found";
////            break;
////    }
////    
////    return @"Hello";
//}
//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
//    NSInteger section = [indexPath section];
//    
//    switch (section) {
//        case 0:
//             cell.textLabel.text = [self.sections[section] objectAtIndex:indexPath.row];
//            break;
//        case 1:
//            cell.textLabel.text = [self.sections[section] objectAtIndex:indexPath.row];
//            break;
//        case 2:
//            cell.textLabel.text = [self.sections[section] objectAtIndex:indexPath.row];
//            break;
//        default:
//            cell.textLabel.text = @"Could not find section.";
//            break;
//    }
    
    BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
    
    if ([blogPost.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData = [NSData dataWithContentsOfURL:[blogPost thumbnailURL]];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.image = image;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"hn-logo.png"];
    }
   
    
    cell.textLabel.text = [blogPost title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"by %@, %@", blogPost.author, [blogPost daysAgo]];
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showBlogPost"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
        [segue.destinationViewController setBlogPostURL:blogPost.url];
    }
}

@end
