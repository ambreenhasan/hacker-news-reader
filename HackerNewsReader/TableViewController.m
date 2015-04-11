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
    
    NSURL *topStoriesURL = [NSURL URLWithString:@"https://hacker-news.firebaseio.com/v0/topstories.json"];
    
    NSData  *jsonData = [NSData dataWithContentsOfURL:topStoriesURL];
    
    NSError *error = nil;
    
    NSDictionary *hackerNewsDictionary;

    self.blogPosts = [NSMutableArray array];
    
    NSArray *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSArray *firstFifteenArticles = [dataDictionary subarrayWithRange:NSMakeRange(0, 15)];
    
    for (NSInteger index = 0; index < firstFifteenArticles.count; index++) {
        NSURL *storyInformationURL = [NSURL URLWithString:
                                      [NSString stringWithFormat:@"https://hacker-news.firebaseio.com/v0/item/%@.json?print=pretty",
                                       firstFifteenArticles[index]]];
        
        NSData  *jsonData = [NSData dataWithContentsOfURL:storyInformationURL];
        
        hackerNewsDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        
        BlogPost *blogPost = [BlogPost blogPostWithTitle:[hackerNewsDictionary objectForKey:@"title"]];
        blogPost.author = [hackerNewsDictionary objectForKey:@"by"];
        NSString *timeConverter = [NSString stringWithFormat:@"%@",[hackerNewsDictionary objectForKey:@"time"]];
        blogPost.date = timeConverter;
        blogPost.url = [NSURL URLWithString:[hackerNewsDictionary objectForKey:@"url"]];
        [self.blogPosts addObject:blogPost];
    }
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
    
    if ([blogPost.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData = [NSData dataWithContentsOfURL:[blogPost thumbnailURL]];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.image = image;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"hn-logo.png"];
    }
   
    
    cell.textLabel.text = [blogPost title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"by %@, %@", blogPost.author, [blogPost unixTimestampConverter]];
    
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
